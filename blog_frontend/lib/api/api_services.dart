import 'dart:convert';
import 'dart:io';

import 'package:blog_frontend/main.dart';
import 'package:blog_frontend/models/blog_model.dart';
import 'package:blog_frontend/models/login_model.dart';
import 'package:blog_frontend/models/registration_accepted_model.dart';
import 'package:blog_frontend/models/registration_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const apiLink = 'http://127.0.0.1:8000/';

class ApiServices {
  Future<dynamic> postBlog(
      {required String title,
      required String blogText,
      required int user,
      required File file}) async {
    var formData = FormData.fromMap({
      'title': title,
      'blog_text': blogText,
      'main_image': await MultipartFile.fromFile(file.path, filename: title),
      'user': user
    });
    final response = await Dio().post(
      '$apiLink+api/home/blog-user/',
      data: formData,
    );
    if (response.statusCode == 201) {
      var raw = jsonDecode(response.data['data']);
      return BlogModel.fromJson(raw);
    }
    var rawError = jsonDecode(response.data['message']);
    return rawError;
  }

  Future<List<BlogModel>> fetchPublicBlogList() async {
    var response = await http.get(Uri.parse('$apiLink/api/home/blog'));
    if (response.statusCode == 200) {
      var contentRaw = jsonDecode(response.body);
      var blog = contentRaw['data'] as List;
      return blog.map((e) => BlogModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch data from the given api!');
    }
  }

  Future<List<BlogModel>> fetchUserBlogList() async {
    String at = pref.getString('at') ?? '';
    debugPrint(at);
    var response = await http.get(Uri.parse('${apiLink}api/home/blog-user'),
        headers: {'Authorization': 'Bearer $at'});
    if (response.statusCode == 200) {
      var contentRaw = jsonDecode(response.body);
      debugPrint(response.body.toString());
      var blog = contentRaw['data'] as List;
      return blog.map((e) => BlogModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch data from the given api!');
    }
  }

  Future<dynamic> deleteBlog({required String uid}) async {
    String at = pref.getString('at') ?? '';
    var response = await http.delete(Uri.parse('${apiLink}api/home/blog-user/'),
        body: {'uid': uid}, headers: {'Authorization': 'Bearer $at'});
    if (response.statusCode == 200 || response.statusCode == 204) {
      return jsonDecode(response.body)['message'];
    } else {
      return jsonDecode(response.body);
    }
  }

  Future<RegistrationAcceptedModel> register(
      {required RegistrationModel model}) async {
    var response =
        await http.post(Uri.parse('${apiLink}api/account/register/'), body: {
      'first_name': model.firstName,
      'last_name': model.lastName,
      'username': model.username,
      'password': model.password
    });
    if (response.statusCode == 201) {
      return RegistrationAcceptedModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      return RegistrationAcceptedModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to Register');
    }
  }

  Future<dynamic> login({required LoginModel model}) async {
    var response =
        await http.post(Uri.parse('${apiLink}api/account/login/'), body: {
      'username': model.username,
      'password': model.password,
    });
    if (response.statusCode == 202) {
      return jsonDecode(response.body);
    } else {
      return {
        "message": "invalid credentials",
        "data": {
          "token": {"refresh": "", "access": ""}
        }
      };
    }
  }
}
