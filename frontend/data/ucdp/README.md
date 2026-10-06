# UCDP Georeferenced Event Dataset (GED)

`ged_events_2000_2025.csv.gz` is a slimmed extract of the UCDP GED v25.1 dataset
(Davies, Pettersson & Öberg 2025; Sundberg & Melander 2013), restricted to events
from 2000 onwards and to the columns used by `visualizations/conflicts/index.qmd`:
`id, latitude, longitude, date_start, type_of_violence, deaths_a, deaths_b, deaths_civilians`.

The full raw file (`GEDEvent_v25_1.csv`, ~250 MB) is git-ignored. It can be
downloaded from https://ucdp.uu.se/downloads/ and regenerated with:

```python
import csv
cols = ["id","latitude","longitude","date_start","type_of_violence","deaths_a","deaths_b","deaths_civilians"]
with open("GEDEvent_v25_1.csv", newline="") as f, open("ged_events_2000_2025.csv", "w", newline="") as g:
    w = csv.DictWriter(g, fieldnames=cols); w.writeheader()
    for row in csv.DictReader(f):
        if int(row["year"]) >= 2000:
            w.writerow({c: row[c] for c in cols})
```

then `gzip -9 ged_events_2000_2025.csv`.
