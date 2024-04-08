import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final Icon icon;
  const CustomTextField({super.key, required this.icon, required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null ||
            value.isEmpty ||
            value.toString().trim().length == 0)
          return "please enter correct text ";
        return null;
      },
      decoration: InputDecoration(
          prefixIcon: icon,
          filled: true,
          fillColor: Colors.white12,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)),
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.grey),
          hintText: hint),
    );
  }
}
