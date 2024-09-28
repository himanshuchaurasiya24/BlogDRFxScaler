from rest_framework.views import APIView
from rest_framework.response import Response
from .serializer import BlogSerializer
from .models import *
from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework_simplejwt.authentication import JWTAuthentication
from django.db.models import Q
from django.core.paginator import Paginator
class PublicBlogView(APIView):
    def get(self, request):
        try:
            blogs = Blog.objects.all().order_by('?')
            if request.GET.get('search'):
                search = request.GET.get('search')
                print(search)
                object = object.filter(Q(title__icontains= search)| Q(blog_text__icontains=search))
            # serializer = BlogSerializer(object, many=True)
            page_number = request.GET.get('page', 1)
            paginator = Paginator(blogs, 5) # 5 denotes the number of data in the form of list.
            serializer=BlogSerializer(paginator.page(page_number), 
                                      many=True)
            return Response ({'data':serializer.data, 
                              'message':'blog fetched successfully'} ,
                             status=status.HTTP_200_OK)
        except Exception as e:
            return Response({'message':"Something exceptional has occured", 
                             'data':e}, 
                            status=status.HTTP_400_BAD_REQUEST)

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
    def delete(self, request):
        try:
            data = request.data
            blog = Blog.objects.filter(uid= data.get('uid'))
            
            if not blog.exists():
                return Response({'data':{}, 
                                 'message':'No such uid blog exists.'},
                                status=status.HTTP_204_NO_CONTENT)
            if request.user != blog[0].user:
                return Response({'data':{}, 
                                 'message':'No blog for this user exists.'}, 
                                status=status.HTTP_204_NO_CONTENT)
            blog[0].delete()
                                       
            return Response({'data':{},
                             'message':'This blog has been deleted.'}, 
                             status=status.HTTP_200_OK)
        except Exception as e:
                return Response({'message':"Something exceptional has occured", 
                                'data':e}, 
                                status=status.HTTP_400_BAD_REQUEST)

    def patch(self, request):
        try:
            data = request.data
            print(data)
            blog = Blog.objects.filter(uid= data.get('uid'))
            if not blog.exists():
                return Response({'data':{}, 'message':'No blog found for this uid.'}, status=status.HTTP_204_NO_CONTENT)
            if request.user  !=blog[0].user:
                return Response({'data':{},
                                 'message':'You are not authorized to do this.' }, 
                                  status=status.HTTP_400_BAD_REQUEST)
            serializer=BlogSerializer(blog[0],data=data,partial=True)
            if not serializer.is_valid():
                return Response({'data':serializer.errors,
                                 'message':'something went wrong.' }, 
                                status=status.HTTP_400_BAD_REQUEST)
            serializer.save()
            return Response({'data':serializer.data,'message':'blog updated successfully'}, status=status.HTTP_202_ACCEPTED)
        except Exception as e:
                return Response({'message':"Something exceptional has occured", 
                                'data':e}, 
                                status=status.HTTP_400_BAD_REQUEST)
