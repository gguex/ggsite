# ggsite

Academic portfolio of Guillaume Guex: teaching material, data visualizations,
simulations and algorithm demos. Built with [Quarto](https://quarto.org).

## Layout

```
frontend/                Quarto website
  _quarto.yml            site config (navbar, theme, freeze)
  _freeze/               cached R / Python outputs (versioned)
  _extensions/           Quarto extensions (versioned)
  assets/                styles, images, CV, citation style
  data/                  shared datasets (personal_data, geojson, ucdp, ...)
  index.qmd              About page (CV from data/personal_data/cv.yaml,
                         publications from references.bib)
  teaching/              one folder per course, sessions inside
  visualizations/        one folder per visualization
  simulations/           one folder per demo (section in reserve: draft, not published)
  sandbox/               work in progress (draft, not published)
backend/                 optional FastAPI backend (see backend/README.md)
```

Every section (`teaching/`, `visualizations/`, `simulations/`) is a listing:
add a folder containing an `index.qmd` with `title`, `description`, `date`,
`image` and `categories` in its front matter and it shows up in the grid.
Settings shared by a section live in its `_metadata.yml`.

## Setup

```bash
python -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
```

R packages used by the pages: `tidyverse`, `readr`, `dplyr`, `tidyr`,
`lubridate`, `readxl`, `knitr`, `quarto`, `FactoMineR`, `factoextra`, `psych`,
`QuantPsyc`.

## Preview, render, publish

```bash
cd frontend
quarto preview                   # http://localhost:4200, published pages only
quarto preview --profile sandbox # same, plus the draft pages (sandbox/, backend demo) in full
quarto render                    # builds _site/, drafts excluded
quarto publish gh-pages          # renders and pushes _site/ to the gh-pages branch
```

Draft pages are not linked from any listing, so open them by URL, e.g.
`http://localhost:4200/sandbox/leaflet_tuto/`. The `sandbox` profile lives in
`frontend/_quarto-sandbox.yml` and only sets `draft-mode: visible`.

Computational outputs are cached in `_freeze/` (`execute: freeze: auto`):
a page is re-executed only when its source changes. Commit `_freeze/` together
with the page.
