import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void createSnackBar(
    String message, BuildContext context, Color text, Color background) {
  final snackBar = new SnackBar(
    content: new Text(
      message,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: text,
      ),
      textAlign: TextAlign.center,
    ),
    backgroundColor: background,
    behavior: SnackBarBehavior.floating,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
