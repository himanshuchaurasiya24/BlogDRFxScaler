import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.context,
    required this.hintText,
    required this.controller,
    this.passwordField=false,
  });
  final BuildContext context;
  final String hintText;
  final TextEditingController controller;
  final bool passwordField;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: widget.controller,
          obscureText:widget.passwordField? !isPasswordVisible:false,
          decoration: InputDecoration(
            hintText: widget.hintText,
            suffixIcon: widget.passwordField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                    icon: Icon(
                      !isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  )
                : null,
            filled: true,
            fillColor: Colors.white70,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        )
      ],
    );
  }
}
