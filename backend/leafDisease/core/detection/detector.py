from collections import Counter
import shutil
import torch

import cv2
import random

import numpy as np
import os

from ..indentification.Identifier import Objidentify


def detect_and_crop(image):
    # Load YOLOv5 model
    model = torch.hub.load(
        "ultralytics/yolov5", "custom", "core/detection/best.pt", skip_validation=True
    )

    output_dir = "core/saveImg"

    if os.path.exists(output_dir):  # check if the subfolder already exists
        shutil.rmtree(output_dir)  # delete the subfolder and its contents

    os.makedirs(output_dir)  # create the subfolder

    # Run inference on the input image
    results = model(image)
    bbox = results.xyxy[0]

    # save image into temp
    # results.show()  # or .show(), .save(), .crop(), .pandas(), etc.
    results.save("/", "core/saveImg/leafDetection")

    # print(type(image))

    # Initialize a counter for the output image filenames
    number = 0

    # Convert the PIL image to a numpy array
    numpy_array = cv2.cvtColor(np.array(image), cv2.COLOR_RGB2BGR)

    # Load the input image
    # img = cv2.imread(numpy_array)
    img = numpy_array

    # Loop through the detected objects and crop the corresponding regions from the input image
    detections = bbox[:].tolist()
    for detection in detections:
        detection = [int(x) for x in detection]

        # Extract the rectangular region from the input image
        crop_img = img[detection[1]: detection[3], detection[0]: detection[2]]

        mloutput = Objidentify(crop_img)
        number += 1

        # Write the cropped image to the output directory
        cv2.imwrite(f"{output_dir}/{random.randrange(1,10000)}.png", crop_img)

    word_counts = Counter(mloutput)
    most_common_word = word_counts.most_common(1)[0][0]

    identification_result = most_common_word + \
        "is the most common identification amount" + \
        str(word_counts) + " results"

    folder_path = "core/saveImg/"
    files = os.listdir(folder_path)

    I = []
    A = []

    for file_name in files:
        file_path = os.path.join(folder_path, file_name)
        if os.path.isfile(file_path):
            basename = os.path.splitext(file_name)[0]
            I.append(int(basename))

    result = {
        "Disease Images": {
            "D": [0000],
            "I": I,
            "A": [2155, 5557]
        },
        "ResultInfo": identification_result,
        "Disease Name": most_common_word,
        "Disease Infomations": "Causal organism: Several fungal species. Symptoms: Seedlings appear healthy initially, but suddenly collapse and die. The stem at the soil line becomes water-soaked and brown. Roots may also be decayed.",
        "Prevention Method": "Use of treated seeds. Avoid overwatering and use well-draining soil. Use of fungicides and biocontrol agents. Maintain proper sanitation in the growing area."
    }

    return result
