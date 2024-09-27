from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.views import APIView
from .serializer import *
from rest_framework import status
class RegisterView(APIView):
    def post(self, request):
        data= request.data
        serializer= RegisterSerializer(data=data)
        try:
            if not serializer.is_valid():
                return Response({'message':'somthing went wrong',
                "data":serializer.errors}, status=status.HTTP_400_BAD_REQUEST)
            # serializer.create(serializer.data)
            serializer.save()
            obj= User.objects.all()
            for o in obj:
                print(o.first_name)
                print(o.last_name)
                
            return Response({'message':'account has been created.','data':serializer.data}, 
            status=status.HTTP_201_CREATED)

        except Exception as e:
            return Response({'message':'some error has occured.', 'data':str(e)}, status= status.HTTP_400_BAD_REQUEST)
class LoginView(APIView):
    def post(self, request):
        try:
            data = request.data
            # print(data['password'])
            serializer= LoginSerializer(data=data)
            if not serializer.is_valid():
                return Response({
                    'data':serializer.errors,
                    'message':'somthing went wrong.'
                }, status=status.HTTP_400_BAD_REQUEST)
            response = serializer.get_jwt_token(serializer.data)
            # print(response)
            return Response(response, status=status.HTTP_202_ACCEPTED)
        except Exception as e:
            # print(e)
            return Response({'data':{},
                             'message':'somthing went wrong in exception.'
            }, status=status.HTTP_400_BAD_REQUEST)