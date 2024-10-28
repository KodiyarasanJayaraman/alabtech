import 'package:alabtech/AuthScreen/login_screen.dart';
import 'package:alabtech/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCDDFQ4GQIeklzJMV8EqY9LNd0ZVwGtZN8",
          appId: "1:1096040117426:android:40f854b2415889fd7145ab",
          messagingSenderId: "1096040117426",
          projectId: "alabtech-53731"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: (FirebaseAuth.instance.currentUser?.uid != null)
          ? const HomeScreen()
          : const LoginScreen(),
    );
  }
}
