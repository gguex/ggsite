# UNHCR refugee and asylum-seeker flows

Both files were produced on 2026-10-06 from the `refugees::population` dataset
(UNHCR Refugee Data Finder, R package `refugees`) for the years 2000 onwards:

- `global_totals_2000_2025.csv`: refugees + asylum-seekers recorded per year, all corridors.
- `refugee_flows_2000_2025.csv`: corridors (origin -> asylum) above 5,000 people, with
  ISO numeric codes (`countrycode`) and country centroids from
  https://raw.githubusercontent.com/google/dspl/master/samples/google/canonical/countries.csv.

Pipeline (R):

```r
library(dplyr); library(tidyr); library(refugees); library(countrycode)
all <- refugees::population %>% filter(year >= 2000) %>%
  group_by(year, coo_iso, coa_iso) %>%
  summarize(total = sum(refugees, asylum_seekers, na.rm = TRUE), .groups = "drop")
totals <- all %>% group_by(year) %>% summarize(true_total = sum(total), .groups = "drop")
cent <- read.csv("<countries.csv url>", na.strings = "") %>% select(iso2_code = country, lat = latitude, lon = longitude)
flows <- all %>% filter(total > 5000) %>%
  mutate(coo_iso2 = countrycode(coo_iso, "iso3c", "iso2c"), coa_iso2 = countrycode(coa_iso, "iso3c", "iso2c"),
         origin_continent = ifelse(coo_iso == "NAM", "Africa", countrycode(coo_iso, "iso3c", "continent")),
         origin_num = countrycode(coo_iso, "iso3c", "iso3n"), dest_num = countrycode(coa_iso, "iso3c", "iso3n")) %>%
  inner_join(cent, by = c("coo_iso2" = "iso2_code")) %>% rename(origin_lat = lat, origin_lon = lon) %>%
  inner_join(cent, by = c("coa_iso2" = "iso2_code")) %>% rename(dest_lat = lat, dest_lon = lon)
```

Used by `visualizations/refugee_flows/index.qmd`.
