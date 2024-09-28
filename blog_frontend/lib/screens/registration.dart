import 'package:blog_frontend/components/custom_page_route.dart';
import 'package:blog_frontend/components/custom_scaffold.dart';
import 'package:blog_frontend/components/glass_morphism.dart';
import 'package:blog_frontend/screens/login_screen.dart';
import 'package:flutter/material.dart';

import '../components/custom_text_field.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Register",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          GlassMorphism(
            borderRadius: 15,
            containerOpacity: 0.08,
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.2,
              width: MediaQuery.of(context).size.width / 1.1,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Please enter your details for registration',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    CustomTextField(
                      context: context,
                      hintText: 'First Name',
                      controller: firstNameController,
                    ),
                    CustomTextField(
                      context: context,
                      hintText: 'Last Name',
                      controller: lastNameController,
                    ),
                    CustomTextField(
                      context: context,
                      hintText: 'Username',
                      controller: usernameController,
                    ),
                    CustomTextField(
                      context: context,
                      hintText: 'password',
                      controller: passwordController,
                      passwordField: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GlassMorphism(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _isLoading = true;
                            });
                          },
                          child: _isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white70,
                                    strokeWidth: 6,
                                  ),
                                )
                              : Text(
                                  'Register',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account ?',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              CustomPageRoute(
                                route: const LoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Login instead',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}