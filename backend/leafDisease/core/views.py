from django.http import JsonResponse
from PIL import Image
from django.views.decorators.csrf import csrf_exempt
from .detection.detector import detect_and_crop


@csrf_exempt
def detect(request):
    if request.method == "POST" and request.FILES.get("image"):
        image_file = request.FILES["image"]
        image = Image.open(image_file)
        result = detect_and_crop(image)

        result = {
            "Disease Images": "None",
            "Disease Name": "Bacterial wilt",
            "Disease Infomations": "Causal organism: Ralstonia solanacearum Symptoms:Slight wilting of single branch/ branches Sudden and permanent wilting of entire plant Discoloration of the vascular tissues Slimy viscous bacterial ooze comes out from the cut end of affected parts when immersed in clear",
            "Prevention Method": "Management Remove and destroy affected plants with soil Destroy crop debris after harvesting Crop rotation with non-susceptible crop (cruciferous vegetables and okra) help in reducing the disease incidence Use of resistant varieties Disinfect all farm implements/tools with bleach after they have been No chemical controlling method",
        }

        return JsonResponse(result)

    else:
        return JsonResponse("ALL Good")


def info(request):
    if request.method == "GET":
        return JsonResponse(
            {
                "Disease Images": "None",
                "Disease Name": "Bacterial wilt",
                "Disease Infomations": "Causal organism: Ralstonia solanacearum Symptoms:Slight wilting of single branch/ branches Sudden and permanent wilting of entire plant Discoloration of the vascular tissues Slimy viscous bacterial ooze comes out from the cut end of affected parts when immersed in clear",
                "Prevention Method": "Management Remove and destroy affected plants with soil Destroy crop debris after harvesting Crop rotation with non-susceptible crop (cruciferous vegetables and okra) help in reducing the disease incidence Use of resistant varieties Disinfect all farm implements/tools with bleach after they have been No chemical controlling method",
            }
        )
