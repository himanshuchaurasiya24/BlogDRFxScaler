from django.contrib import admin
from django.urls import path, include
from .views import *
urlpatterns = [
    path('blog-user/', BlogView.as_view()),
    path('blog/', PublicBlogView.as_view())
]
