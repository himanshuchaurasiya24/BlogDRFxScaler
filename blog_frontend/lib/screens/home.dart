// Future<void> checkConnectivity() async {
//   try {
//     final result = await InternetAddress.lookup('google.com');
//     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//       debugPrint('connected');
//       debugPrint(result.toString());
//     }
//   } on SocketException catch (_) {
//     debugPrint('not connected');
//   }
// }
// checkConnectivity();
// import 'dart:io';
import 'package:blog_frontend/components/custom_page_route.dart';
import 'package:blog_frontend/main.dart';
import 'package:blog_frontend/screens/add_new_blog_screen.dart';
import 'package:blog_frontend/screens/bottomNavScreens/profile_bottom.dart';
import 'package:blog_frontend/screens/bottomNavScreens/home_bottom.dart';
import 'package:blog_frontend/screens/login_screen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.accessToken, required this.username});
  final String accessToken;
  final String username;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  List<Widget> appList = [const HomeBottom(), const ProfileBottom()];
  int activePage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.verified_user),
              label: 'Profile',
            ),
          ],
          onTap: (value) {
            setState(() {
              activePage = value;
            });
          },
        ),
        appBar: AppBar(
          title: Text(
            '@${widget.username}',
            style: const TextStyle(color: Colors.black87),
          ),
          actions: [
            IconButton(
              onPressed: () {
                pref.remove('at');
                Navigator.pushReplacement(
                    context, CustomPageRoute(route: const LoginScreen()));
              },
              icon: const Icon(
                Icons.logout_rounded,
                color: Colors.red,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            Navigator.push(
              context,
              CustomPageRoute(
                route: const AddNewBlogScreen(),
              ),
            ).then(
              (value) {
                setState(() {
                  activePage = 1;
                });
              },
            );
          },
          label: const Text('new blog'),
          icon: const Icon(Icons.add),
        ),
        body: appList[activePage]);
  }
}
