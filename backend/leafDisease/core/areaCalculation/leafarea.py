import cv2
import numpy as np
from ultralytics import YOLO
from .damagearea import calculate_leaf_damage


def calculate_leaf_area(image_path):
    model = YOLO('core\\areaCalculation\\LeafDetection.pt')
    results = model.predict(source=image_path, conf=0.25)

    originalImg = results[0].orig_img
    mask = (results[0].masks.data[0].cpu().numpy() * 255).astype("uint8")
    mask = cv2.resize(mask, (originalImg.shape[1], originalImg.shape[0]))

    num_white_pixels = np.sum(mask == 255)

    # Calculate the total number of pixels
    total_pixels = mask.shape[0] * mask.shape[1]

    # Calculate the percentage of white pixels in the image
    leaf_area_percentage = num_white_pixels / total_pixels * 100

    masked_image = cv2.bitwise_and(originalImg, originalImg, mask=mask)

    leaf_damage_percentage, masked_image = calculate_leaf_damage(masked_image)

    alpha = 0.3
    highlight_area = cv2.addWeighted(
        originalImg, 1-alpha, masked_image, alpha, 0)

    # Apply gamma correction to reduce brightness in highlight area
    gamma = 0.8
    highlight_area = np.power(highlight_area/255.0, gamma)
    highlight_area = (highlight_area*255.0).astype(np.uint8)

    # leaf_damage_percentage = num_white_pixels / leaf_damage_percentage * 100

    print(f'Total leaf area: {num_white_pixels}')
    print(f'Total Damage area: {leaf_damage_percentage}')

    total = ((num_white_pixels - leaf_damage_percentage) /
             num_white_pixels) * 100

    print(total*1.02)

    return leaf_area_percentage, highlight_area


# image_path = 'core\\saveImg\\6280.png'

# leaf_area_percentage, masked_image = calculate_leaf_area(image_path)

# cv2.imshow('leafAreaImage', masked_image)
# cv2.waitKey(0)
# cv2.destroyAllWindows()
