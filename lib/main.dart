import 'package:astrollo_app/auth/auth_wrapper.dart';
import 'package:astrollo_app/screens/login_flow/initial.dart';
import 'package:astrollo_app/screens/main/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

// used with fab transition
final routeObserver = RouteObserver<PageRoute>();
final duration = const Duration(milliseconds: 200);

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.black));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Astrollo",
      theme: ThemeData(
        fontFamily: "Cagile",
      ),
      debugShowCheckedModeBanner: false,
      home: AuthWrapper(), // * ------------------ test stage
      navigatorObservers: [routeObserver],
    );
  }
}
