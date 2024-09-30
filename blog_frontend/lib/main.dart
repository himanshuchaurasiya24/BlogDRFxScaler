// ignore_for_file: unused_import

import 'package:blog_frontend/screens/home.dart';
import 'package:blog_frontend/screens/login_screen.dart';
import 'package:blog_frontend/screens/registration.dart';
import 'package:blog_frontend/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences pref;
void main() async {
  pref = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[300],
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            color: Colors.white70,
            fontSize: 60,
            fontFamily: 'Ubuntu-Bold',
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: TextStyle(
            color: Colors.white70,
            fontSize: 45,
            fontFamily: 'Ubuntu-Bold',
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle(
            color: Colors.white70,
            fontSize: 30,
            fontFamily: 'Ubuntu-Medium',
          ),
          bodySmall: TextStyle(
            color: Colors.white70,
            fontSize: 20,
            fontFamily: 'Ubuntu-Regular',
          ),
          headlineSmall: TextStyle(
            color: Colors.white70,
            fontSize: 30,
            fontFamily: 'Ubuntu-Regular',
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
