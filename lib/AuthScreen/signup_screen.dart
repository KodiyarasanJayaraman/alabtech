import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Widgets/text_field_widget.dart';
import '../Widgets/text_widget.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final lastName = TextEditingController();
  final emailId = TextEditingController();
  final password = TextEditingController();
  final phoneNo = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool visiblePassword = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            body: Center(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
                  .001,
                  .25,
                  .75,
                  1,
                ],
                colors: [
                  Colors.orange.shade400,
                  Colors.orange.shade200,
                  Colors.orange.shade200,
                  Colors.orange.shade400
                ],
              )),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: TextWidget(
                      text: 'Sign up',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  /// Enter your Details
                  const TextWidget(
                    text: 'Enter Details below',
                    fontSize: 18,
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  /// TextField for Name
                  TextFieldWidget(
                    customErrorText: 'Name',
                    inputType: TextInputType.text,
                    hintText: 'Name',
                    controller: nameController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  /// TextField for Email
                  TextFieldWidget(
                    customErrorText: 'Email',
                    inputType: TextInputType.emailAddress,
                    hintText: 'Email',
                    controller: emailId,
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  /// TextField for Password
                  TextFieldWidget(
                    customErrorText: "Password",
                    inputType: TextInputType.visiblePassword,
                    hintText: "Password",
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

                  /// TextField for Phone Number

                  TextFieldWidget(
                    customErrorText: "PhoneNumber",
                    inputType: TextInputType.phone,
                    hintText: "PhoneNumber",
                    controller: phoneNo,
                    maxLength: 10,
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  /// Already Have an Account Text
                  RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginScreen(),
                                    ),
                                    (route) => false,
                                  );
                                },
                              text: 'Sign In here',
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue,
                                // fontWeight: FontWeight.w400,
                                fontSize: 14,
                              )),
                        ],
                        text: "Already have an account?   ",
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.black)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  /// Sign Up  Button
                  GestureDetector(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        var name = '${nameController.text} ';
                        final newUser = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: emailId.text, password: password.text)
                            .catchError(
                          (error) {
                            Fluttertoast.showToast(msg: error.toString());
                          },
                        );
                        var userId = FirebaseAuth.instance.currentUser?.uid;
                        if (newUser != null) {
                          await FirebaseAuth.instance.currentUser
                              ?.updateDisplayName(nameController.text);
                          await FirebaseAuth.instance.currentUser?.reload();
                        }
                        if (newUser != null) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                            (route) => false,
                          );
                        }
                        CollectionReference collRef =
                            FirebaseFirestore.instance.collection('users');
                        collRef.doc(userId).set({
                          'name': nameController.text,
                          'email': emailId.text,
                          'PhoneNumber': phoneNo.text,
                          "uid": userId,
                        });
                      } else {}
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.deepOrange.shade600.withOpacity(.8),
                          borderRadius: BorderRadius.circular(8)),
                      alignment: Alignment.center,
                      child:
                          // loading == true ?
                          // CircularProgressIndicator(color: AppColor.black,) :
                          const TextWidget(
                        text: 'Sign up',
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
