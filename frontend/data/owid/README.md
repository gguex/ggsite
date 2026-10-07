# Our World in Data – energy consumption

`energy_consumption_regions.csv` is an extract of the Our World in Data energy dataset
(https://github.com/owid/energy-data, file `owid-energy-data.csv`, downloaded on
2026-10-07; data from the Energy Institute Statistical Review of World Energy and
others, licensed CC BY 4.0). It keeps the regions World, Europe, North America, Asia,
South America and Africa, the years from 1965 for which coal, oil and gas are all
reported (this drops the current, incomplete year), and the primary energy consumption
columns in TWh: coal, oil, gas, nuclear, hydro, wind, solar, other renewables.

Used by `visualizations/energy/index.qmd`. To refresh it, download the full CSV and run:

```python
import csv
regions = {"World", "Europe", "North America", "Asia", "South America", "Africa"}
cols = ["country","year","coal_consumption","oil_consumption","gas_consumption","nuclear_consumption",
        "hydro_consumption","wind_consumption","solar_consumption","other_renewable_consumption"]
with open("owid-energy-data.csv", newline="") as f, open("energy_consumption_regions.csv", "w", newline="") as g:
    w = csv.DictWriter(g, fieldnames=cols); w.writeheader()
    for row in csv.DictReader(f):
        if row["country"] in regions and int(row["year"]) >= 1965 \
           and all(row[c] != "" for c in ("coal_consumption", "oil_consumption", "gas_consumption")):
            w.writerow({c: row[c] for c in cols})
```
