import 'dart:async';

import 'package:alabtech/AuthScreen/signup_screen.dart';
import 'package:alabtech/home_screen.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Widgets/text_field_widget.dart';
import '../Widgets/text_widget.dart';
import 'auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isEmailChecker = false;
  AuthService authClass = AuthService();
  bool loading = false;
  bool visiblePassword = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
          body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
                  .5,
                  1.0,
                ],
                colors: [Colors.blueGrey, Colors.grey],
              )),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: TextWidget(
                      text: 'Login',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  ///  Email  Login
                  TextFieldWidget(
                    customErrorText: "Please enter email",
                    inputType: TextInputType.emailAddress,
                    hintText: "Email",
                    controller: email,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldWidget(
                    inputType: TextInputType.text,
                    hintText: "Password",
                    customErrorText: "Enter Password",
                    controller: password,
                    obscureText: !visiblePassword,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          visiblePassword = (!visiblePassword);
                        });
                      },
                      child: Icon(
                        visiblePassword
                            ? CupertinoIcons.eye
                            : CupertinoIcons.eye_slash,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  /// Login
                  AbsorbPointer(
                    absorbing: loading == true,
                    child: GestureDetector(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: email.text.trim(),
                                  password: password.text.trim())
                              .then((value) async {
                            Fluttertoast.showToast(
                                msg:
                                    'Welcome! ${FirebaseAuth.instance.currentUser?.displayName}');
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()),
                                (route) => false);
                            setState(() {
                              loading = false;
                            });
                          }).catchError((onError) {
                            if (onError.toString() ==
                                "[firebase_auth/invalid-credential] The supplied auth "
                                    "credential "
                                    "is incorrect, malformed or has expired.") {
                              Fluttertoast.showToast(
                                  msg:
                                      'The supplied auth credential is incorrect');
                            }
                            setState(() {
                              loading = false;
                            });
                          });
                        }
                      },

                      /// Login and Next Button
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: CupertinoColors.systemGreen,
                            borderRadius: BorderRadius.circular(8)),
                        alignment: Alignment.center,
                        child: loading == true
                            ? const CircularProgressIndicator(
                                color: Colors.black,
                              )
                            : const TextWidget(
                                textAlign: TextAlign.center,
                                text: "Login",
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),

                  /// Don't Have Account Text
                  RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SignupScreen(),
                                    ),
                                    (route) => false,
                                  );
                                },
                              text: 'Sign up here',
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              )),
                        ],
                        text: "Don't have an account? ",
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.black)),
                  ),
                  const SizedBox(
                    height: 40,
                  ),

                  ///DottedLine
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 42.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: DottedLine()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32.0),
                          child: TextWidget(
                            text: 'or',
                            fontSize: 16,
                          ),
                        ),
                        Expanded(child: DottedLine())
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  /// Continue Google Button
                  GestureDetector(
                      onTap: () {
                        authClass.handleGoogleSignIn(context);
                      },
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 220),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                            border: Border.all(width: 2),
                            borderRadius: BorderRadius.circular(40)),
                        child: Row(
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/google.png',
                              height: 32,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              "Sign in with Google",
                              // fontSize: 14,
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
