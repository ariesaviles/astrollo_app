import 'package:astrollo_app/auth/auth_wrapper.dart';
import 'package:astrollo_app/screens/login_flow/initial.dart';
import 'package:astrollo_app/screens/main/home.dart';
import 'package:astrollo_app/services/auth_service.dart';
import 'package:astrollo_app/global_comps/user_object.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:provider/provider.dart';

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
    return StreamProvider<User>.value(
      value: AuthService().user,
        child: MaterialApp(           
            theme: ThemeData(
              fontFamily: "Cagile",
            ),
            debugShowCheckedModeBanner: false,
            home: AuthWrapper(), // * ------------------ test stage
            navigatorObservers: [routeObserver],
        ),
    );
  }
}
