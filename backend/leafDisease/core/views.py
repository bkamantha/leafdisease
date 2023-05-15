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

        # Save result as a JSON file
        result_filename = "result.json"
        result_file_path = os.path.join(
            "core/", result_filename)
        with open(result_file_path, "w") as f:
            json.dump(result, f)

        return JsonResponse(result, safe=False)

    elif request.method == "GET":

        # Read saved JSON file and return as JSON response
        result_filename = "result.json"
        result_file_path = os.path.join(
            "core/", result_filename)
        if os.path.isfile(result_file_path):
            with open(result_file_path, "r") as f:
                result = json.load(f)

            return JsonResponse(result, safe=False)
        else:
            return JsonResponse("Result not found.")

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

        try:
            if image_type == "D":
                pil_image = Image.open('core/saveImg/leafDetection/image0.jpg')

            elif image_type == "I":
                pil_image = Image.open(f'core/saveImg/{image_name}.png')

            elif image_type == "A":
                pil_image = Image.open(f'core/saveImg/leafarea/{image_name}.png')

            elif image_type == "F":
                pil_image = Image.open(f'core/diseaseImg/{image_name}.jpg')

        except:
            pil_image = Image.open('core/diseaseImg/0000.png')

        # Convert the Pillow image back to bytes
        with BytesIO() as buffer:
            pil_image.save(buffer, format="PNG")
            image_data = buffer.getvalue()

        # Set the content type of the response to the MIME type of the image
        content_type = "image/png"
        response = HttpResponse(content_type=content_type)
        response.write(image_data)

        return response
