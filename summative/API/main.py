from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import joblib
import pandas as pd
import logging

# Initialize the app
app = FastAPI()

# Enable logging for debugging
logging.basicConfig(level=logging.INFO)

# Load the retrained model
model_retrained = joblib.load('models/retrained_model.pkl')

# Extract the feature names used during training
important_features = model_retrained.feature_names_in_.tolist()

# Define the Pydantic model for request validation
class PredictionRequest(BaseModel):
    Animal_Name_clam: float
    Animal_Name_slug: float
    Animal_Name_seawasp: float
    Animal_Name_worm: float
    Animal_Name_octopus: float
    Hair: float
    Feathers: float
    Backbone: float
    Class_Type: float
    Fins: float

    class Config:
        schema_extra = {
            "example": {
                "Animal_Name_clam": 1.0,
                "Animal_Name_slug": 0.0,
                "Animal_Name_seawasp": 0.0,
                "Animal_Name_worm": 0.0,
                "Animal_Name_octopus": 0.0,
                "Hair": 1.0,
                "Feathers": 0.0,
                "Backbone": 1.0,
                "Class_Type": 2.0,
                "Fins": 0.0
            }
        }

@app.post("/predict")
def predict(request: PredictionRequest):
    try:
        # Log the incoming request
        logging.info(f"Received request: {request.json()}")
        
        # Convert input data to a DataFrame
        request_data = request.dict()
        df_input = pd.DataFrame([request_data])

        # Ensure input DataFrame matches the model's feature order
        df_input = df_input[important_features]

        # Make a prediction
        prediction = model_retrained.predict(df_input)

        # Return the prediction result
        return {"prediction": prediction[0]}

    except KeyError as ke:
        error_message = f"Missing or incorrect feature: {ke}"
        logging.error(error_message)
        raise HTTPException(status_code=400, detail=error_message)
    except Exception as e:
        logging.error(f"Prediction failed: {e}")
        raise HTTPException(status_code=500, detail="An unexpected error occurred during prediction.")

@app.get("/health")
def health_check():
    """
    Health check endpoint to verify if the API is running.
    """
    return {"status": "ok"}

@app.get("/")
def root():
    """
    Root endpoint to provide information about the API.
    """
    return {
        "message": "Welcome to the Prediction API!",
        "endpoints": {
            "/predict": "Make predictions using the model",
            "/health": "Check API health"
        }
    }
