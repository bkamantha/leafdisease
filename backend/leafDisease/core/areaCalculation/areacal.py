from ultralytics import YOLO
import cv2
import numpy as np


def areaCal():
    # Load the YOLOv8 model
    model = YOLO(
        'backend\\leafDisease\\core\\areaCalculation\\areadetection.pt')

    # Load the image
    img = 'backend\\leafDisease\\core\\saveImg\\8598.png'

    # Use the YOLOv5 model to detect objects in the image
    results = model.predict(source=img, conf=0.25)

    # Annotate the image with the detected objects
    annotated_frame = results[0].plot()

    # Convert the annotated image to a NumPy array
    np_frame = np.asarray(annotated_frame)

    # Display the annotated image using OpenCV
    cv2.imshow("Annotated Image", np_frame)
    cv2.waitKey(0)
    cv2.destroyAllWindows()
