from keras.models import load_model
from PIL import Image, ImageOps
import numpy as np

# Disable scientific notation for clarity
np.set_printoptions(suppress=True)

# Load the model
model = load_model("core\indentification\Identifier_model.h5", compile=False)

# Load the labels
class_names = [line.rstrip("\n")
               for line in open("core\indentification\labels.txt")]

result = []


def Objidentify(cropImage):
    print(type(cropImage))

    # Convert numpy array to PIL Image object
    image = Image.fromarray(np.uint8(cropImage)).convert("RGB")

    # Resize and crop the image
    size = (224, 224)
    image = ImageOps.fit(image, size, Image.Resampling.LANCZOS)

    # Convert PIL Image object to numpy array
    image_array = np.array(image)

    # Normalize the image
    normalized_image_array = (image_array.astype(np.float32) / 127.5) - 1

    # Load the image into the array
    data = np.ndarray(shape=(1, 224, 224, 3), dtype=np.float32)
    data[0] = normalized_image_array

    # Predict the class of the object in the image
    prediction = model.predict(data)
    index = np.argmax(prediction)

    class_name = class_names[index]
    confidence_score = prediction[0][index]

    # Print prediction and confidence score
    print("Class:", class_name, end="")
    print("Confidence Score:", confidence_score)

    result.append(class_name)

    return result
