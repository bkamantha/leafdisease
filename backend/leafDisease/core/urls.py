from django.urls import path
from . import views

urlpatterns = [
    path("", views.detect, name="detect"),
    path("info", views.info, name="info"),
]
