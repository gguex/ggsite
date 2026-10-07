# Boundaries

- `countries-110m.json`: world country boundaries (TopoJSON, 1:110m) from the
  `world-atlas` npm package v2.0.2 (ISC license), itself derived from Natural Earth
  (public domain). Copied on 2026-10-07 so that the site does not depend on a CDN.
  Used by `visualizations/conflicts/` and `visualizations/refugee_flows/`.
- `switzerland.geojson`: simplified boundaries of the 26 Swiss cantons (GeoJSON,
  one feature per canton with a `name` property). Used by
  `visualizations/swiss_cantons/` and `visualizations/swiss_health_ojs/`.
- `us-counties-10m.json`: US counties (TopoJSON), currently unused.
