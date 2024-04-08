import 'package:e_commerce_app/widget/custom_textfield.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  static String id = "SignUpScreen";
  SignUpScreen({super.key});
  final formKey = GlobalKey<FormState>();
  Widget build(context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              decoration: BoxDecoration(color: Colors.orange),
              padding:
                  EdgeInsets.only(top: 100, left: 20, right: 10, bottom: 30),
              child: Form(
                
                key: formKey,
                child: Column(
                  children: [
                    Container(
                        width: 100,
                        height: 100,
                        child: ClipOval(
                            child: Image(
                                image:
                                    AssetImage('assets/images/icons/but.png')))),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.05,
                    ),
                    CustomTextField(
                        hint: "Enter your mail", icon: Icon(Icons.mail)),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.05,
                    ),
                    CustomTextField(
                        hint: "Enter your password", icon: Icon(Icons.password)),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.05,
                    ),
                    CustomTextField(
                        hint: "Confirm your password",
                        icon: Icon(Icons.password)),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap:(){
                        if(formKey.currentState!.validate()){
                          
                        }
                      },
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 0.35,
                        height: MediaQuery.sizeOf(context).height * 0.04,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                            child: Text('Sign Up ',
                                style: TextStyle(color: Colors.white))),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.only(left: 50),
                      child: Row(
                        children: [
                          Text("already have account",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white)),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Sign In",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
