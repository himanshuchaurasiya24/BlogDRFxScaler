import 'package:blog_frontend/components/custom_page_route.dart';
import 'package:flutter/material.dart';

void replaceToAnotherPage(
    {required BuildContext context, required Widget goto}) {
  Navigator.pushReplacement(
    context,
    CustomPageRoute(
      route: goto,
    ),
  );
}
void navigateToAnotherPage(
    {required BuildContext context, required Widget goto}) {
  Navigator.push(
    context,
    CustomPageRoute(
      route: goto,
    ),
  );
}
