from django.contrib import admin
from django.urls import path, include
from .views import *
urlpatterns = [
    path('blog/', BlogView.as_view()),
    path('public-blog/', PublicBlogView.as_view())
]
