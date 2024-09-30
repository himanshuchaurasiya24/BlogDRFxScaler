import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.accessToken});
  final String accessToken;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.accessToken),
      ),
    );
  }
}
