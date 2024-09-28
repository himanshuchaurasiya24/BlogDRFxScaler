import 'package:blog_frontend/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  final storage = const FlutterSecureStorage();
  Future<bool> readAll() async {
    final allData = await storage.readAll(aOptions: _getAndroidOptions());
    debugPrint(allData.toString());
    return true;
  }

  Future<bool> addToken({required String token}) async {
    final allData = await storage.write(
      key: 'accesss',
      value: 'tokenn',
      aOptions: _getAndroidOptions(),
    );
    readAll();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    addToken(token: 'token');
    
    return CustomScaffold(
      child: Image.asset(
        'assets/images/app_icon.png',
        cacheHeight: 150,
        cacheWidth: 150,
      ),
    );
  }
}
