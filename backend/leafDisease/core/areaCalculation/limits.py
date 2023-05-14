import cv2
import numpy as np

# Load image
image = cv2.imread('backend\\leafDisease\\core\\saveImg\\8598.png')

# Define color range in RGB format
rMin, gMin, bMin = 0, 191, 0
rMax, gMax, bMax = 214, 255, 212

# Create NumPy arrays for lower and upper color bounds
lower = np.array([bMin, gMin, rMin], dtype=np.uint8)
upper = np.array([bMax, gMax, rMax], dtype=np.uint8)

# Apply color threshold to image
mask = cv2.inRange(image, lower, upper)
result = cv2.bitwise_and(image, image, mask=mask)

# Display result image
cv2.imshow('result', result)
cv2.waitKey(0)
cv2.destroyAllWindows()
