import torch
import cv2
import random
from ..indentification.Identifier import Objidentify


def detect_and_crop(image):
    # Load YOLOv5 model
    model = torch.hub.load(
        "ultralytics/yolov5", "custom", "core/detection/best.pt", skip_validation=True
    )

    # Run inference on the input image
    results = model(image)
    bbox = results.xyxy[0]

    # Initialize a counter for the output image filenames
    number = 0

    # Load the input image
    img = cv2.imread("16.jpg")

    # Loop through the detected objects and crop the corresponding regions from the input image
    detections = bbox[:].tolist()
    for detection in detections:
        detection = [int(x) for x in detection]

        # Extract the rectangular region from the input image
        crop_img = img[detection[1] : detection[3], detection[0] : detection[2]]

        Objidentify(crop_img)
        number += 1

        output_dir = "core\saveImg"

        # Write the cropped image to the output directory
        cv2.imwrite(f"{output_dir}/{random.randrange(1,10000)}.png", crop_img)
