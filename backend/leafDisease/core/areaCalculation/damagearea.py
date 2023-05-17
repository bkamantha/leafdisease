import cv2
import numpy as np
from ultralytics import YOLO


def calculate_leaf_damage(image_path):
    model = YOLO('core\\areaCalculation\\DamageDetection.pt')
    results = model.predict(source=image_path, conf=0.25)

    originalImg = results[0].orig_img

    try:
        mask = (results[0].masks.data[0].cpu().numpy() * 255).astype("uint8")

        for i in range(1, len(results[0].masks)):
            mask += (results[0].masks.data[i].cpu().numpy()
                     * 255).astype("uint8")

        mask = cv2.resize(mask, (originalImg.shape[1], originalImg.shape[0]))

        num_white_pixels = np.sum(mask == 255)

        # Calculate the total number of pixels
        # total_pixels = mask.shape[0] * mask.shape[1]

        # Calculate the percentage of white pixels in the image
        # leaf_area_percentage = num_white_pixels / total_pixels * 100

        masked_image = cv2.bitwise_and(originalImg, originalImg, mask=mask)
    except:
        num_white_pixels = 0
        masked_image = originalImg

    return num_white_pixels, masked_image


# image_path = 'core\\saveImg\\6280.png'
# leaf_area_percentage, masked_image = calculate_leaf_area(image_path)
# print(f'Total leaf area: {leaf_area_percentage}%')
# cv2.imshow('leafAreaImage', masked_image)
# cv2.waitKey(0)
# cv2.destroyAllWindows()
