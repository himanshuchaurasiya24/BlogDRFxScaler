import 'dart:io';

import 'package:blog_frontend/api/api_services.dart';
import 'package:blog_frontend/components/custom_text_field.dart';
import 'package:blog_frontend/components/glass_morphism.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({
    super.key,
    required this.title,
    required this.blogText,
    required this.imageURL,
    required this.uid,
  });
  final String title;
  final String blogText;
  final String imageURL;
  final String uid;

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final titleController = TextEditingController();
  final blogTextController = TextEditingController();
  final _picker = ImagePicker();
  File? _selectedImage;
  bool isUploading = false;
  final _formKey = GlobalKey<FormState>();

  Future getImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    } else {
      debugPrint('No image selected');
    }
  }

  Future<void> updateBlog() async {
    if (_selectedImage == null) {
      await ApiServices().updateBlogWithoutImageUpdate(
          title: titleController.text,
          blogText: blogTextController.text,
          uid: widget.uid);
    } else {
      await ApiServices().updateBlogWithImageUpdate(
          title: titleController.text,
          blogText: blogTextController.text,
          uid: widget.uid,
          selectedImage: _selectedImage!);
    }
      Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    titleController.text = widget.title;
    blogTextController.text = widget.blogText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Blog'),
      ),
      body: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                  context: context,
                  hintText: widget.title,
                  controller: titleController),
              CustomTextField(
                  context: context,
                  hintText: widget.blogText,
                  controller: blogTextController),
              GestureDetector(
                onTap: () {
                  getImage();
                },
                child: _selectedImage == null
                    ? Image.network(
                        widget.imageURL,
                        height: 200,
                        width: 400,
                      )
                    : Image.file(
                        _selectedImage!,
                        height: 200,
                        width: 400,
                      ),
              ),
              GlassMorphism(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        updateBlog();
                      }
                    },
                    child: isUploading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white70,
                              strokeWidth: 6,
                            ),
                          )
                        : Text(
                            'Update Blog',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
