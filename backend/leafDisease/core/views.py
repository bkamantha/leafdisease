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

        result = {
            "Disease Images": {
                "D": [5411],
                "I": [5435, 5437],
                "A": [2155, 5557]
            },
            "Disease Name": "Damping-off",
            "Disease Infomations": "Causal organism: Several fungal species. Symptoms: Seedlings appear healthy initially, but suddenly collapse and die. The stem at the soil line becomes water-soaked and brown. Roots may also be decayed.",
            "Prevention Method": "Use of treated seeds. Avoid overwatering and use well-draining soil. Use of fungicides and biocontrol agents. Maintain proper sanitation in the growing area."
        }

        return JsonResponse(result)

    else:
        return JsonResponse("ALL Good")


def info(request):
    if request.method == "GET":

        with open('core\diseases.json', 'r') as f:
            data = json.load(f)

            return JsonResponse(
                data, safe=False
            )


def saveImages(request, image_type, image_name):

    # pil_image = Image.open('core/saveImg/3477.png')

    pil_image = Image.open('core/saveImg/leafDetection/image0.jpg')

    # Convert the Pillow image back to bytes
    with BytesIO() as buffer:
        pil_image.save(buffer, format="PNG")
        image_data = buffer.getvalue()

    # Set the content type of the response to the MIME type of the image
    content_type = "image/png"
    response = HttpResponse(content_type=content_type)
    response.write(image_data)

    return response
