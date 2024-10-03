import 'package:blog_frontend/api/api_services.dart';
import 'package:blog_frontend/models/blog_model.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.accessToken, required this.username});
  final String accessToken;
  final String username;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<BlogModel>> blogModel;
  void fetchBlogList() async {
    blogModel = ApiServices().fetchPublicBlogList();
  }

  @override
  void initState() {
    fetchBlogList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.verified_user),
          label: 'Profile',
        ),
      ]),
      appBar: AppBar(
        title: Text(
          '@${widget.username}',
          style: const TextStyle(color: Colors.black87),
        ),
      ),
      body: FutureBuilder(
        future: blogModel,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.isEmpty) {
            return const Center(child: Text('No data to display.'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                    '${snapshot.data![index].title!} ${snapshot.data![index].user!.toString()}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(snapshot.data![index].blogText!),
                  ],
                ),
                onTap: () async {
                  await ApiServices()
                      .deleteBlog(uid: snapshot.data![index].uid!)
                      .then(
                    (value) {
                      debugPrint(value.toString());
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
