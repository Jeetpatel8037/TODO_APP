import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:practical_exam_1_jeet/views/HomePage.dart';
import 'package:practical_exam_1_jeet/views/Login_Page.dart';
import 'package:practical_exam_1_jeet/views/splash_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      routes: {
        '/': (context) => const SplashScreen(),
        'HomePage': (context) => const HomePage(),
        'Login': (context) => const Login(),
      },
    ),
  );
}
