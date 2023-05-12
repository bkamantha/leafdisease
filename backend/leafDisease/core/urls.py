from django.urls import path
from . import views

urlpatterns = [
    path("", views.detect, name="detect"),
    path("info", views.info, name="info"),
    path("images/<str:image_type>/<str:image_name>",
         views.saveImages, name="save_images"),

    # path("images/d/", views.saveImages, name="detection"),
    # path("images/i/", views.saveImages, name="identification"),
    # path("images/a/", views.saveImages, name="area"),
]
