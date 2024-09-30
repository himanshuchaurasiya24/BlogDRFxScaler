import 'package:blog_frontend/components/custom_scaffold.dart';
import 'package:blog_frontend/main.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void getInfo() async {
    String? accessToken = pref.getString('at') ?? '';
    debugPrint('accessToken is : $accessToken');
  }

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Image.asset(
        'assets/images/app_icon.png',
        cacheHeight: 150,
        cacheWidth: 150,
      ),
    );
  }
}
