
import 'package:alyosr_online/new/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



void main()  {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AlYosr Online',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      // home: HomePage(),
      home: SplashScreen(),
      // home: OTPPage(),
    );
  }
}

