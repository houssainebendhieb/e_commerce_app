import 'package:e_commerce_app/constants.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
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
        obscureText: hint == 'Enter your password' ? true : false,
        decoration: InputDecoration(
            prefixIcon: icon,
            filled: true,
            fillColor: kSecondaryColor,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white)),
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white),
            hintText: hint),
      ),
    );
  }
}
