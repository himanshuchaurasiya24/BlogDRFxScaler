from django.contrib import admin
from django.urls import path, include
from account.views import * 
from home.views import *

urlpatterns = [
    path('account/', include('account.urls')),
    path('home/',include('home.urls'))
]