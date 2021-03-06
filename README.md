# poloniex_duration_stats
Generates an overview of the cryptocoin lendings on Poloniex grouped by currency and duration

Add your API key in the file ".config":
```
> key: AAAAAAAA-BBBBBBBB-CCCCCCCC-DDDDDDDD
> secret: 1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghij
```

Example output:
```
> BTC  2:     0.0186   6.8% (0.0200%-0.0290%)
> BTC  3:     0.0160   5.8% (0.0200%-0.0300%)
> BTC  4:     0.0245   8.9% (0.0230%-0.0320%)
> BTC  5:     0.1411  51.7% (0.0250%-0.0300%)
> BTC  6:     0.0412  15.1% (0.0270%-0.0330%)
> BTC  7:     0.0250   9.1% (0.0300%-0.0330%)
> BTC 60:     0.0060   2.2% (0.0900%-0.1970%)
> BTC:        0.2726 100.0% (0.0200%-0.1970%)

> ETH  2:    19.3031  42.6% (0.0180%-0.0350%)
> ETH  3:    12.4408  27.4% (0.0180%-0.0350%)
> ETH  4:     6.2064  13.6% (0.0220%-0.0370%)
> ETH  5:     5.0552  11.1% (0.0250%-0.0300%)
> ETH  6:     0.8213   1.8% (0.0300%-0.0350%) 
> ETH 60:     1.4795   3.2% (0.0620%-0.1000%) 
> ETH:       45.3066 100.0% (0.0180%-0.1000%)
```
