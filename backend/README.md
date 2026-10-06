# Backend (FastAPI)

Optional Python API for computations that are too heavy to run in the browser
(algorithm demos, simulations). The site works without it.

## Run locally

```bash
source .venv/bin/activate            # from the repository root
uvicorn backend.main:app --reload --port 8000
```

- `GET  /`                    health check
- `POST /api/run-simulation`  example endpoint (`{"x": 10, "y": 5}` -> product)

## Adding an algorithm

1. Define a Pydantic model for the inputs in `main.py`.
2. Add a route under `/api/...` that calls your code.
3. Call it from a page with `fetch(`${API_URL}/api/...`)` (see
   `frontend/simulations/backend_demo/index.qmd`).

## Deploying later

- Host the API on a small service (Render, Fly.io, Hugging Face Spaces, ...).
- Add the production site URL to `origins` in `main.py` (CORS).
- Point `API_URL` in the demo pages to the deployed address.
- Remove `draft: true` from the demo pages so they appear in the listing.
