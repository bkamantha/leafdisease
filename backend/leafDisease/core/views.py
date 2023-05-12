from io import BytesIO
import os
from django.http import JsonResponse
from django.http import HttpResponse, Http404

from PIL import Image
from django.views.decorators.csrf import csrf_exempt
from .detection.detector import detect_and_crop
import json


@csrf_exempt
def detect(request):
    if request.method == "POST" and request.FILES.get("image"):
        image_file = request.FILES["image"]
        image = Image.open(image_file)
        result = detect_and_crop(image)

        return JsonResponse(result, safe=False)

    else:
        return JsonResponse("Something went wrong.")


def info(request):
    if request.method == "GET":

        with open('core\diseases.json', 'r') as f:
            data = json.load(f)

            return JsonResponse(
                data, safe=False
            )


def saveImages(request, image_type, image_name):
    if request.method == "GET":
        if image_type == "D":
            pil_image = Image.open('core/saveImg/leafDetection/image0.jpg')

        elif image_type == "I":
            pil_image = Image.open(f'core/saveImg/{image_name}.png')

        elif image_type == "A":
            pil_image = Image.open(f'core/saveImg/{image_name}.png')

        # Convert the Pillow image back to bytes
        with BytesIO() as buffer:
            pil_image.save(buffer, format="PNG")
            image_data = buffer.getvalue()

        # Set the content type of the response to the MIME type of the image
        content_type = "image/png"
        response = HttpResponse(content_type=content_type)
        response.write(image_data)

        return response
