import 'package:blog_frontend/api/api_services.dart';
import 'package:blog_frontend/models/blog_model.dart';
import 'package:flutter/material.dart';

class HomeBottom extends StatefulWidget {
  const HomeBottom({super.key});

  @override
  State<HomeBottom> createState() => _HomeBottomState();
}

class _HomeBottomState extends State<HomeBottom> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: [
        BlogModel(blogText: '', mainImage: '', title: '', uid: '', user: null)
      ],
      future: ApiServices().fetchPublicBlogList(),
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
    );
  }
}
