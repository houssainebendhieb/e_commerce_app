import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final Icon icon;
  final Function onClick;
  const CustomTextField(
      {super.key,
      required this.onClick,
      required this.icon,
      required this.hint});

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
      onChanged: (value) {
        onClick(value);
      },
      obscureText: hint == 'Enter your mail' ? false : true,
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
