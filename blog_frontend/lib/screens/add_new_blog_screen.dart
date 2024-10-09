import 'dart:io';
import 'package:blog_frontend/api/api_services.dart';
import 'package:blog_frontend/components/custom_text_field.dart';
import 'package:blog_frontend/components/glass_morphism.dart';
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
  bool isUploading = false;
  final _picker = ImagePicker();
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

  Future<void> uploadBlog() async {
    setState(() {
      isUploading = true;
    });
    await ApiServices()
        .uploadBlog(
            title: titleController.text,
            blogText: blogTextController.text,
            selectedImage: _selectedImage!)
        .then(
      (value) {
        Navigator.pop(context);
      },
    );
  }

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
              Visibility(
                visible: _selectedImage == null,
                child: IconButton(
                  onPressed: () {
                    getImage();
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
              ),
              SizedBox(
                height: 300,
                width: 300,
                child: _selectedImage != null
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedImage = null;
                          });
                        },
                        child: Image.file(
                          _selectedImage!,
                          height: 200,
                          width: 400,
                        ))
                    : const SizedBox(),
              ),
              GlassMorphism(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        uploadBlog();
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
                            'Upload Blog',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
