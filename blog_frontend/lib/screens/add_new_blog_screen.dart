import 'dart:io';
import 'package:blog_frontend/api/api_services.dart';
import 'package:blog_frontend/components/custom_text_field.dart';
import 'package:blog_frontend/components/glass_morphism.dart';
import 'package:blog_frontend/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

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
    int user = pref.getInt('user') ?? 0;
    String at = pref.getString('at') ?? '';
    setState(() {
      isUploading = true;
    });
    var request = http.MultipartRequest(
        "POST", Uri.parse('${apiLink}api/home/blog-user/'));
    request.fields['title'] = titleController.text;
    request.fields['blog_text'] = blogTextController.text;
    request.fields['user'] = user.toString();
    request.headers['Authorization'] = 'Bearer $at';
    debugPrint(at);
    request.files.add(
        await http.MultipartFile.fromPath('main_image', _selectedImage!.path));
    var response = await request.send();
    debugPrint(response.toString());
    debugPrint(response.reasonPhrase);
    debugPrint(response.stream.toString());
    debugPrint(response.statusCode.toString());
    debugPrint(response.headers.toString());
    setState(() {
      isUploading = false;
    });
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
                        child: Image.file(_selectedImage!))
                    : const SizedBox(),
              ),
              GlassMorphism(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    onPressed: () async {
                      uploadBlog();
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
