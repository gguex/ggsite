# Guillaume Guex — academic portfolio

Hello! This repository holds the source of my personal website, where I share
my teaching material and interactive data visualizations. The site is built
with [Quarto](https://quarto.org), with a bit of R, Python and Observable
JavaScript, and is published as a static site.

**Live site:** https://gguex.github.io/ggsite/

## What you will find on the site

- **Teaching** — slides, notebooks and exercises of the courses I give at the
  University of Lausanne (quantitative methods, machine learning, data analysis
  for the humanities, databases). The courses are in French.
- **Visualizations** — interactive maps and animations built with D3 and
  Observable: armed conflicts, refugee flows, wealth inequality, global
  warming, the Swiss cantons, and more.
- **About me** — a short bio, my résumé and my publications.

## Why the code is public

Mostly so that colleagues and students can see how such a site is put together.
Feel free to borrow the structure, the listing setup or the visualizations as a
starting point for your own work. If you reuse a visualization, a link back is
appreciated. The course material is mine unless stated otherwise on the page;
please ask before redistributing it.

## How it is built

Each section of the site is a Quarto *listing*: a folder per course or
visualization, with an `index.qmd` describing it (`title`, `description`,
`date`, `image`, `categories`), and the section page picks it up
automatically. Settings shared by a section live in its `_metadata.yml`.

Computations in R and Python are cached in `_freeze/`, which is versioned,
so the site can be rendered without re-running them. The visualizations load
their data from `frontend/data/`, where each dataset has a `README.md` with its
source and license.

```
frontend/                  the Quarto website
  _quarto.yml              site configuration (navbar, theme, footer, freeze)
  index.qmd                About page (résumé from data/personal_data/cv.yaml,
                           publications from references.bib)
  teaching/                one folder per course, one section per session
  visualizations/          one folder per visualization
  data/                    datasets used by the pages, with their READMEs
  assets/                  styles, images, CV, citation style, favicon
  _freeze/                 cached computational outputs
  _extensions/             Quarto extensions
  sandbox/                 work in progress (drafts, not published)
  simulations/             section kept in reserve (drafts, not published)
backend/                   optional FastAPI API, not used by the published site
                           (see backend/README.md)
```

## Running the site locally

You need [Quarto](https://quarto.org/docs/get-started/) (1.4 or later),
Python 3.10+ and R. Then:

```bash
git clone https://github.com/gguex/ggsite.git
cd ggsite
python -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt

cd frontend
quarto preview                    # opens http://localhost:4200
```

Thanks to the cache, most pages render without R or Python. If you edit a page
that runs R, you will need these packages: `tidyverse`, `readr`, `dplyr`,
`tidyr`, `lubridate`, `readxl`, `knitr`, `FactoMineR`, `factoextra`, `psych`,
`QuantPsyc`.

Draft pages are hidden from the normal preview. To see them as well:

```bash
quarto preview --profile sandbox  # also shows sandbox/ and simulations/
```

Drafts are not linked from any listing, so open them by URL, for example
`http://localhost:4200/sandbox/leaflet_tuto/`.

To build the whole site into `frontend/_site/`:

```bash
quarto render
```

## Contact

Questions, corrections or ideas are welcome: open an issue here, or write to
me at guillaume.guex@gmail.com. You can also find me on
[ORCID](https://orcid.org/0000-0003-1001-9525) and
[LinkedIn](https://linkedin.com/in/guillaume-guex/).

## License

*To be decided before the repository goes public — see the note in the
conversation.* A common choice for this kind of repository is the MIT license
for the code and CC BY 4.0 for the texts and visualizations.
