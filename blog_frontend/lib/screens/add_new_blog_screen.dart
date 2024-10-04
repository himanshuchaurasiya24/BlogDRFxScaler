import 'dart:io';

import 'package:blog_frontend/components/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddNewBlogScreen extends StatefulWidget {
  const AddNewBlogScreen({super.key});

  @override
  State<AddNewBlogScreen> createState() => _AddNewBlogScreenState();
}

class _AddNewBlogScreenState extends State<AddNewBlogScreen> {
  final titleController = TextEditingController();
  final blogTextController = TextEditingController();
  final userIdController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  File? _selectedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a blog'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                context: context,
                hintText: 'title',
                controller: titleController,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                context: context,
                hintText: 'blog text',
                controller: blogTextController,
              ),
              const SizedBox(
                height: 10,
              ),
              IconButton(
                onPressed: () async {
                  final pickedImage = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (pickedImage != null) {
                    setState(() {
                      _selectedImage = File(pickedImage.path);
                    });
                  } else {
                    //
                  }
                },
                icon: Row(
                  children: [
                    const Icon(
                      Icons.add,
                      size: 40,
                      color: Colors.black87,
                    ),
                    Text(
                      'Pick an image from here.',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black87),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 300,
                width: 300,
                child: _selectedImage != null
                    ? Image.file(_selectedImage!)
                    : const SizedBox(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
