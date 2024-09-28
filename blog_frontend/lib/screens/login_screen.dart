import 'package:blog_frontend/api/api_services.dart';
import 'package:blog_frontend/components/custom_page_route.dart';
import 'package:blog_frontend/components/custom_scaffold.dart';
import 'package:blog_frontend/components/custom_text_field.dart';
import 'package:blog_frontend/components/glass_morphism.dart';
import 'package:blog_frontend/models/login_model.dart';
import 'package:blog_frontend/screens/registration.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Login",
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
                      'Please enter your credentials for Login',
                      style: Theme.of(context).textTheme.headlineSmall,
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
                          onPressed: () async {
                            setState(() {
                              _isLoading = true;
                              ApiServices()
                                  .login(
                                      model: LoginModel(
                                          username: usernameController.text,
                                          password: passwordController.text))
                                  .then(
                                (value) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  debugPrint(
                                      value.data!.token!.access.toString());
                                },
                              );
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
                                  'Login',
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
                          'Don\'t have an account ?',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              CustomPageRoute(
                                route: const Registration(),
                              ),
                            );
                          },
                          child: Text(
                            'Register here',
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
