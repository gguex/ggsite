from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

# CORS Configuration
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

# First Endpoint
@app.get("/")
def read_root():
    return {"message": "Bienvenue sur l'API de ggsite !"}

# Second Endpoint
@app.get("/api/status")
def get_status():
    return {"status": "online", "version": "1.0.0"}