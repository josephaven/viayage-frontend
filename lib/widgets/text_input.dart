import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;

  TextInput({required this.label, required this.controller, this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
