import numpy as np
import os
from fastapi import FastAPI, File, UploadFile, HTTPException
from fastapi.responses import HTMLResponse
from fastapi.responses import JSONResponse
from fastapi.exceptions import RequestValidationError
from pydantic import BaseModel
from PIL import Image
import tensorflow as tf
from io import BytesIO
import uvicorn
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

origins = [
    "http://127.0.0.1:8000",
]

# Configure CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allow requests from any origin
    allow_credentials=True,
    allow_methods=["*"],  # Allow all requests
    allow_headers=["*"],  # Allow any headers
)
class Item(BaseModel):
    title: str
    size: int

@app.exception_handler(RequestValidationError)
async def validation_exception_handler(request, exc):
    return JSONResponse(
        status_code=422,
        content={"detail": exc.errors(), "body": exc.body},
    )

# Load the pre-trained model
MODEL = tf.keras.models.load_model('model1.h5')
CLASS_NAMES = ['Aloe vera','Amaranthus-Viridis','Basale','Betel','Carissa-Karanda','Curry plant','Ficus-Auriculata','Ginger','Guava leaf','Hibiscus','Holy Basil','Jackfruit','Jamaica-Cherry','Jasmine','Lemon','Mango','Mint','Moringa','Mustard','Neem','Oleander','Pappaya','Peepal','Rasna','Sandalwood plant','Turmeric plant','Unlabeled']

#def read_file_as_image(data) -> np.ndarray:
#    img = Image.open(BytesIO(data)).convert('RGB')
#    img_resized = img.resize((224, 224), resample=Image.BICUBIC)
#    return np.array(img_resized)

def read_file_as_image(data) -> np.ndarray:
    img = Image.open(BytesIO(data)).convert('RGB')
    img_resized = img.resize((224, 224), resample=Image.BICUBIC)
    img_array = np.array(img_resized).astype(np.float32)  # Convert to float32
    img_array = img_array / 255.0  # Normalize to [0,1]
    return img_array
@app.post("/predict")
async def predict(file: UploadFile = File(...)):
    try:
        image = read_file_as_image(await file.read())
        img_batch = np.expand_dims(image, axis=0)
        predictions = MODEL.predict(img_batch)
        predicted_class = CLASS_NAMES[np.argmax(predictions[0])]
        confidence = np.max(predictions[0]) * 100  # Convert to percentage
        confidence_rounded = min(round(confidence), 100)  # Round and cap at 100
        return {
            'class': predicted_class,
            'confidence': confidence_rounded  # Return rounded confidence
        }
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

@app.get("/")
async def main():
    return HTMLResponse(content="<h1>Upload an image for prediction</h1>")

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 8000)) 
    uvicorn.run(app, host="0.0.0.0", port=port)