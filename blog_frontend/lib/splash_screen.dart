import 'package:blog_frontend/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
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
