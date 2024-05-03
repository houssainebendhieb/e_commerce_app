import 'package:e_commerce_app/provider/adminhome.dart';
import 'package:e_commerce_app/provider/modelhud.dart';
import 'package:e_commerce_app/screens/admin/adminpage.dart';
import 'package:e_commerce_app/screens/homepage.dart';
import 'package:e_commerce_app/screens/signup_screen.dart';
import 'package:e_commerce_app/widget/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/services/auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static String id = "LoginScreen";
  LoginScreen({super.key});
  String _email = "x", _password = "x";
  void changeEmail(String email) {
    _email = email;
  }

  void changePassword(String password) {
    _password = password;
  }

  final _auth = new Auth();
  final globalKey = new GlobalKey<FormState>();

  Widget build(context) {
    return ModalProgressHUD(
      inAsyncCall: Provider.of<ModelHud>(context).isLoading,
      child: SafeArea(
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Form(
                key: globalKey,
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height,
                  decoration: BoxDecoration(color: Colors.orange),
                  padding: EdgeInsets.only(
                      top: 100, left: 20, right: 10, bottom: 30),
                  child: Column(
                    children: [
                      Container(
                          width: 100,
                          height: 100,
                          child: ClipOval(
                              child: Image(
                                  image: AssetImage('images/icons/but.png')))),
                      const SizedBox(
                        height: 50,
                      ),
                      CustomTextField(
                          onClick: changeEmail,
                          hint: "Enter your mail",
                          icon: Icon(Icons.mail)),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.05,
                      ),
                      CustomTextField(
                          onClick: changePassword,
                          hint: "Enter your password",
                          icon: Icon(Icons.password)),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.05,
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.35,
                        height: MediaQuery.sizeOf(context).height * 0.04,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                            child: Builder(
                          builder: (context) => GestureDetector(
                            onTap: () async {
                              print('tap');
                              final modelhud =
                                  Provider.of<ModelHud>(context, listen: false);
                              final adminhome = Provider.of<AdminHome>(context,
                                  listen: false);
                              modelhud.changeisLoading(true);
                              if (globalKey.currentState!.validate()) {
                                if (adminhome.isAdmin) {
                                  if (_password == "admin1234") {
                                    try {
                                      await _auth.SignIn(_email, _password);
                                      modelhud.changeisLoading(false);
                                      Navigator.pushNamed(
                                          context, AdminPage.id);
                                    } on FirebaseAuthException catch (e) {
                                      modelhud.changeisLoading(false);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content:
                                                  Text(e.message.toString())));
                                    }
                                  } else {
                                    modelhud.changeisLoading(false);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "incorrect password for admin ")));
                                  }
                                } else {
                                  try {
                                    await _auth.SignIn(_email, _password);
                                    modelhud.changeisLoading(false);
                                    Navigator.pushNamed(context, HomePage.id);
                                  } on FirebaseAuthException catch (e) {
                                    modelhud.changeisLoading(false);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text(e.message.toString())));
                                  }
                                }
                              }
                              modelhud.changeisLoading(false);
                            },
                            child: Text('Login ',
                                style: TextStyle(color: Colors.white)),
                          ),
                        )),
                      ),
                      const SizedBox(height: 20),
                      Container(
                          padding: EdgeInsets.only(left: 50),
                          child: Row(
                            children: [
                              Text("you don't hava account",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white)),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, SignUpScreen.id);
                                },
                                child: Text("Sign up",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          )),
                      Builder(
                        builder: (context) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Provider.of<AdminHome>(context, listen: false)
                                      .changeIsAdmin(true);
                                },
                                child: Text(
                                  'i\'m Admin',
                                  style: TextStyle(
                                      color: Provider.of<AdminHome>(context)
                                              .isAdmin
                                          ? Colors.white
                                          : Colors.grey),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Provider.of<AdminHome>(context, listen: false)
                                      .changeIsAdmin(false);
                                },
                                child: Text('i\'m a user',
                                    style: TextStyle(
                                        color: Provider.of<AdminHome>(context)
                                                .isAdmin
                                            ? Colors.grey
                                            : Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ))),
    );
  }

  void _validate(BuildContext context) async {
    print(_password);
  }
}
