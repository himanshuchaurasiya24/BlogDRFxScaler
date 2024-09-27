from rest_framework.views import APIView
from rest_framework.response import Response
from .serializer import BlogSerializer
from .models import *
from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework_simplejwt.authentication import JWTAuthentication
from django.db.models import Q
class BlogView(APIView):
    permission_classes=[IsAuthenticated]
    authentication_classes=[JWTAuthentication]
    def get(self, request):
        try:
            object = Blog.objects.filter(user = request.user)
            if request.GET.get('search'):
                search = request.GET.get('search')
                print(search)
                object = object.filter(Q(title__icontains= search)| Q(blog_text__icontains=search))
            serializer = BlogSerializer(object, many=True)
            return Response (serializer.data)
        except Exception as e:
            return Response({'message':"Something exceptional has occured", 
                             'data':e}, 
                            status=status.HTTP_400_BAD_REQUEST)
    def post(self, request):
        try:
            data = request.data
            print('########')
            print(request.user.id)
            print('########')
            serializer = BlogSerializer(data=data)
            if not serializer.is_valid():
                return Response({'data':serializer.errors, 
                                 'message':'something went wrong'}, 
                                 status=status.HTTP_400_BAD_REQUEST)
            serializer.save()
            return Response({'data':serializer.data, 
                             'message':'Blog has been posted'}, 
                            status=status.HTTP_201_CREATED)
        except Exception as e:
            print(e)


