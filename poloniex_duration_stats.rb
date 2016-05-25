#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'

require 'pry'
require 'poloniex'
require 'yaml'
require 'bigdecimal'

class Float
  def format(round,digits)
    f = BigDecimal.new(self.to_s).round(round, BigDecimal::ROUND_DOWN).to_f.to_s
    vor_komma, nach_komma = f.split('.')
    "#{vor_komma.rjust(digits, ' ')}.#{nach_komma.ljust(round, '0')}"
  end
end

class Object
  def present?
    !self.nil? && !self.empty?
  end
end

Poloniex.setup do |config|
  configuration = YAML.load(File.open('.config'))
  config.key = configuration["key"]
  config.secret = configuration["secret"]
end

begin
active_loans = Poloniex.client.send(:post, 'returnActiveLoans')

provided_loans = active_loans['provided'].collect {|loan|
  {
    currency: loan["currency"].to_sym,
    rate: BigDecimal(loan["rate"]),
    amount: BigDecimal(loan["amount"]),
    duration: loan["duration"],
    date: DateTime.parse(loan["date"])
  }
}
rescue Exception => e
  puts e.to_s
  puts e.backtrace
  exit(0)
end

currencies = provided_loans.map {|loan| loan[:currency] }.uniq.sort

currencies.each {|currency|
  loans = provided_loans.select {|l| l[:currency] == currency}
  total = loans.inject(0) {|sum,l| sum += l[:amount] }.to_f

  (2..60).each {|duration|
    filtered_loans = loans.select {|l| l[:duration] == duration}
    amount = filtered_loans.inject(0) {|sum,l| sum += l[:amount] }.to_f
    next if amount == 0.0

    min = (filtered_loans.min_by {|l| l[:rate] }[:rate].to_f*100).round(3)
    max = (filtered_loans.max_by {|l| l[:rate] }[:rate].to_f*100).round(3)

    puts "#{currency} #{duration.to_s.rjust(2)}:  #{amount.format(4,4)}  #{(amount*100/total).format(1,2)}% (#{min.format(4,1)}%-#{max.format(4,1)}%)"
  }

  min = (loans.min_by {|l| l[:rate] }[:rate].to_f*100).round(3)
  max = (loans.max_by {|l| l[:rate] }[:rate].to_f*100).round(3)
  puts "#{currency}:     #{total.format(4,4)} 100.0% (#{min.format(4,1)}%-#{max.format(4,1)}%)"
  puts
}
