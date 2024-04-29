import 'package:e_commerce_app/provider/modelhud.dart';
import 'package:e_commerce_app/screens/homepage.dart';
import 'package:e_commerce_app/widget/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/services/auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  static String id = "SignUpScreen";
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final globalKey = GlobalKey<FormState>();

  final formKey = GlobalKey<FormState>();

  final _auth = new Auth();

  String _email = "", _password = "", _confirmedpassword = "";

  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Form(
            key: globalKey,
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              decoration: BoxDecoration(color: Colors.orange),
              padding:
                  EdgeInsets.only(top: 100, left: 20, right: 10, bottom: 30),
              child: Column(
                children: [
                  Container(
                      width: 100,
                      height: 100,
                      child: ClipOval(
                          child: Image(
                              image: AssetImage('images/icons/but.png')))),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.05,
                  ),
                  CustomTextField(
                      onClick: (value) {
                        _email = value;
                      },
                      hint: "Enter your mail",
                      icon: Icon(Icons.mail)),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.05,
                  ),
                  CustomTextField(
                      onClick: (value) {
                        _password = value;
                      },
                      hint: "Enter your password",
                      icon: Icon(Icons.password)),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.05,
                  ),
                  CustomTextField(
                      onClick: (value) {
                        _confirmedpassword = value;
                      },
                      hint: "Confirm your password",
                      icon: Icon(Icons.password)),
                  const SizedBox(
                    height: 20,
                  ),
                  Builder(
                    builder: (context) => GestureDetector(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          print(_password);
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
                            child: GestureDetector(
                          onTap: () async {
                            final modelhud =
                                Provider.of<ModelHud>(context, listen: false);
                            modelhud.changeisLoading(true);
                            if (globalKey.currentState!.validate()) {
                              try {
                                UserCredential user =
                                    await _auth.SignUp(_email, _password);
                                Navigator.pushNamed(context, HomePage.id);
                                modelhud.changeisLoading(false);

                                print(user.user!.uid);
                              } on FirebaseAuthException catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(e.message.toString())));
                              }
                              modelhud.changeisLoading(false);
                            }
                          },
                          child: Text('Sign Up ',
                              style: TextStyle(color: Colors.white)),
                        )),
                      ),
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
          ),
        ),
      ),
    );
  }
}
