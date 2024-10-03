import 'dart:convert';

import 'package:blog_frontend/models/login_model.dart';
import 'package:blog_frontend/models/login_token_model.dart';
import 'package:blog_frontend/models/registration_accepted_model.dart';
import 'package:blog_frontend/models/registration_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const apiLink = 'http://127.0.0.1:8000/';

class ApiServices {
  Future<RegistrationAcceptedModel> register(
      {required RegistrationModel model}) async {
    var response = await http.post(Uri.parse('${apiLink}api/account/register/'), body: {
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

  Future<LoginTokenModel> login({required LoginModel model}) async {
    var response = await http
        .post(Uri.parse('${apiLink}api/account/login/'), body: {
      'username': model.username,
      'password': model.password,
    });
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 202) {
      return LoginTokenModel.fromJson(jsonDecode(response.body));
    } else {
      return LoginTokenModel.fromJson({
        "message": "invalid credentials",
        "data": {
          "token": {"refresh": "", "access": ""}
        }
      });
    }
  }
}
