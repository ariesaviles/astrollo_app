import 'package:astrollo_app/screens/login_flow/initial.dart';
import 'package:astrollo_app/screens/main/home.dart';
import 'package:astrollo_app/global_comps/user_object.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// tutorial by The Net Ninja
class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    // returns home or login screen
    if (user == null) {
      return InitialPage();
    } else {
      return MyHomePage();
    }
  }
}
