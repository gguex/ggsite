# World Inequality Database (WID) – US wealth shares

`wid_shweal_US_raw.csv` is the raw output of `wid::download_wid(indicators = "shweal",
areas = "US", perc = c("p0p50", "p50p90", "p90p100", "p99p100"))`, downloaded on
2026-10-06 from https://wid.world/ (indicator `shweal`: share of net personal wealth).

Used by `visualizations/wealth_sandpile/index.qmd`, which keeps the variable
`shweal992f` (equal-split adults, all ages) and the years where all four shares exist.
