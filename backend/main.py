from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel

app = FastAPI()

# --- CORS Configuration ---

origins = [
    "http://localhost:4200",    # Quarto Preview Port
    "http://127.0.0.1:4200",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# --- Data model ---

# Basic example model
class SimulationParams(BaseModel):
    x: float
    y: float

# --- Routes ---

# Basic endpoint
@app.get("/")
def read_root():
    return {"message": "ggsite is online"}

# Test the model
@app.post("/api/run-simulation")
def run_simulation(params: SimulationParams):
    """
    Reçoit x et y, et renvoie leur produit.
    C'est ici que tu mettras tes algos complexes plus tard.
    """
    result = params.x * params.y
    return {
        "status": "success",
        "inputs": params,
        "result": result
    }