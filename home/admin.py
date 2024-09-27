from django.contrib import admin
from .models import *
# Register your models here.
# admin.site.register(BaseModel) # can not be registered since it is an abscract model
admin.site.register(Blog)