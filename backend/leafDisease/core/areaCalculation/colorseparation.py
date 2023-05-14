import cv2
import numpy as np


def nothing(x):
    pass


# Load image
image = cv2.imread('backend\\leafDisease\\core\\saveImg\\1135.png')

# Create a window
cv2.namedWindow('image')

# Create trackbars for color change
# RGB is from 0-255 for OpenCV
cv2.createTrackbar('RMin', 'image', 0, 255, nothing)
cv2.createTrackbar('GMin', 'image', 0, 255, nothing)
cv2.createTrackbar('BMin', 'image', 0, 255, nothing)
cv2.createTrackbar('RMax', 'image', 0, 255, nothing)
cv2.createTrackbar('GMax', 'image', 0, 255, nothing)
cv2.createTrackbar('BMax', 'image', 0, 255, nothing)

# Set default value for Max RGB trackbars
cv2.setTrackbarPos('RMax', 'image', 255)
cv2.setTrackbarPos('GMax', 'image', 255)
cv2.setTrackbarPos('BMax', 'image', 255)

# Initialize RGB min/max values
rMin = gMin = bMin = rMax = gMax = bMax = 0
prMin = pgMin = pbMin = prMax = pgMax = pbMax = 0

while (1):
    # Get current positions of all trackbars
    rMin = cv2.getTrackbarPos('RMin', 'image')
    gMin = cv2.getTrackbarPos('GMin', 'image')
    bMin = cv2.getTrackbarPos('BMin', 'image')
    rMax = cv2.getTrackbarPos('RMax', 'image')
    gMax = cv2.getTrackbarPos('GMax', 'image')
    bMax = cv2.getTrackbarPos('BMax', 'image')

    # Set minimum and maximum RGB values to display
    lower = np.array([bMin, gMin, rMin])
    upper = np.array([bMax, gMax, rMax])

    # Color threshold using RGB values
    mask = cv2.inRange(image, lower, upper)
    result = cv2.bitwise_and(image, image, mask=mask)

    # Print if there is a change in RGB value
    if ((prMin != rMin) | (pgMin != gMin) | (pbMin != bMin) | (prMax != rMax) | (pgMax != gMax) | (pbMax != bMax)):
        print("(rMin = %d , gMin = %d, bMin = %d), (rMax = %d , gMax = %d, bMax = %d)" % (
            rMin, gMin, bMin, rMax, gMax, bMax))
        prMin = rMin
        pgMin = gMin
        pbMin = bMin
        prMax = rMax
        pgMax = gMax
        pbMax = bMax

    # Display result image
    cv2.imshow('image', result)
    if cv2.waitKey(10) & 0xFF == ord('q'):
        break

cv2.destroyAllWindows()
