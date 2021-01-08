import 'package:flutter/material.dart';

import 'package:astrollo_app/configs/size_config.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
 // double height = SizeConfig.screenHeight * 5.00;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            color: Color(0xffe8e2d4),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Container(height: SizeConfig.blockSizeVertical * 8),
                    Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.screenHeight * 0.40,
                      child: Image.asset('lib/src/media/images/loginSplashWhite.png',
                          fit: BoxFit.fill),
                    ),
                    Container(
                      width: SizeConfig.screenWidth * .90,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(height: SizeConfig.blockSizeVertical * 2.00),
                          Text('Login',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: "Cagile",
                                  //fontWeight: FontWeight.w500,
                              )
                          ), // ******************************** Login ***************************************
                          Container(height: SizeConfig.blockSizeVertical * 4),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Email',
                              suffixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ), // ---------------------------------- email
                          Container(height: SizeConfig.blockSizeVertical * 2),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Password',
                              suffixIcon: Icon(Icons.visibility_off),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ), // ---------------------------------- password
                          RaisedButton(
                            child: Text('Login'),
                            color: Colors.grey,
                            onPressed: () {},
                          ),

                          Text('- OR -'),

                        ],
                      ),
                    )
                ],
            )
          )
        )
    );
  }
}
