import 'package:astrollo_app/screens/create_new/comps/name_field.dart';
import 'package:astrollo_app/configs/size_config.dart';
import 'package:astrollo_app/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
  Animated Login interface, tutorial from TVAC Studio
 */
class InitialPage extends StatefulWidget {
  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  // login auth
  final AuthService _auth = AuthService();

  // 0 is start, 1 is login, 2 is create new
  int _pageState = 0;

  double _headingOffset = 75;

  var _backgroundColor = Colors.white;
  var _headingColor = Colors.black;

  double _loginWidth = 0;
  double _loginOpacity = 0;

  double _loginYOffset, _loginXOffset = 0;
  double _registerOffset = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final test = TextEditingController();

    switch(_pageState) {
      case 0:
        _backgroundColor = Colors.white;
        _headingColor = Colors.black;

        _headingOffset = 75;

        _loginOpacity = 0;
        _loginWidth = SizeConfig.screenWidth;
        _loginYOffset = SizeConfig.screenHeight;
        _loginXOffset = 0;
        _registerOffset = SizeConfig.screenHeight;
        break;
      case 1:
        _backgroundColor = Color(0xff3f333f);
        _headingColor = Colors.white;

        _headingOffset = 65;

        _loginOpacity = 1;
        _loginWidth = SizeConfig.screenWidth;
        _loginYOffset = SizeConfig.blockSizeVertical * 35;
        _loginXOffset = 0;
        _registerOffset = SizeConfig.screenHeight;
        break;
      case 2:
        _backgroundColor = Color(0xff3f333f);
        _headingColor = Colors.white;

        _headingOffset = 55;

        _loginOpacity = 0.7;
        _loginWidth = SizeConfig.screenWidth - 2 * (SizeConfig.blockSizeHorizontal * 2);
        _loginYOffset = SizeConfig.blockSizeVertical * 32;
        _loginXOffset = SizeConfig.blockSizeHorizontal * 2;
        _registerOffset = SizeConfig.blockSizeVertical * 35;
        break;
    }

    return Material(
      child: Stack(
        children: [
          AnimatedContainer(
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(
              milliseconds: 1000,
            ),
            color: _backgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _pageState = 0;
                    });
                  },
                  child: Container( // *********** Astrollo and text *************
                    //margin: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        AnimatedContainer(
                          curve: Curves.fastLinearToSlowEaseIn,
                          duration: Duration(
                            milliseconds: 1000
                          ),
                          margin: EdgeInsets.only(
                            top: _headingOffset,
                          ),
                          child: Text("Astrollo",
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: "Cagile",
                              fontSize: 50,
                              color: _headingColor,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(30),
                          child: Text("Chart the stars above our hearts.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "FireSans",
                              decoration: TextDecoration.none,
                              fontSize: 25,
                              color: _headingColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container( // ------------ image ---------
                  child: Center(
                    child: Image.asset("lib/assets/images/loginSplashTrans.png"),
                  ),
                ), // image
                Container( // ------- button
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_pageState != 0) {
                          _pageState = 0;
                        } else {
                          _pageState = 1;
                        }
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      height: SizeConfig.blockSizeVertical * 8,
                      margin: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: Color(0xff3f333f),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Center(
                        child: Text(
                          "Get Started",
                          style: TextStyle(
                            //fontFamily: "FireSans",
                            decoration: TextDecoration.none,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ),
                  )
                ), // button
              ],
            ),
          ),
          GestureDetector( // ------------------------- Login Container -----------------------
            onTap: () {
              setState(() {
                _pageState = 2;
              });
            },
            child: AnimatedContainer(
              //color: Colors.white,
              width: _loginWidth,
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(
                milliseconds: 1000,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(_loginOpacity),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                )
              ),
              transform: Matrix4.translationValues(_loginXOffset, _loginYOffset, 1),
              child: Column(
                children: <Widget> [
                  NameField(hint: "email or phone number", controller: test,),
                  Divider(color: Colors.black, indent: 50, endIndent: 50,),
                  NameField(hint: "password", controller: test,),
                  Divider(color: Colors.black, indent: 50, endIndent: 50,),
                  PrimaryButton(text: "Sign in"),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Or sign in with:",
                      style: TextStyle(
                          fontSize: 14, color: Colors.black54, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Divider(color: Colors.black, indent: 20, endIndent: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Don't have an account?:",
                      style: TextStyle(
                          fontSize: 14, color: Colors.black54, fontWeight: FontWeight.w600),
                    ),
                  ),
                  //OutlineButton(text: "Join Astrollo"),
                Container( // ------- button
                    child: GestureDetector(
                      onTap: () async {
                        // dynamic because it could return null or User object
                        dynamic result = await _auth.signInGuest();
                        if (result == null) {
                          print('error signing in');
                        } else {
                          print('signed in:\n');
                          print(result);
                        }
                      },
                      child: Container(
                          width: double.infinity,
                          height: SizeConfig.blockSizeVertical * 7,
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            border: Border.all(color: Colors.black, width: 2,),
                          ),
                          child: Center(
                            child: Text(
                              "Join Astrollo",
                              style: TextStyle(
                                //fontFamily: "FireSans",
                                decoration: TextDecoration.none,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          )
                      ),
                    )

                ),
                ]
              ), // * Login Container contents
            ),
          ),
          GestureDetector( // ------------------------- Sign Up Container -----------------------
            onTap: () {
              setState(() {
                _pageState = 1;
              });
            },
            child: AnimatedContainer(
              //color: Colors.white,
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(
                milliseconds: 1000,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  )
              ),
              transform: Matrix4.translationValues(0, _registerOffset, 1),
            ),
          ),
        ],
      ),
    );
  }
}
 class PrimaryButton extends StatefulWidget {
   PrimaryButton({Key key, this.text});

   final String text;

   @override
   _PrimaryButtonState createState() => _PrimaryButtonState();
 }
 
 class _PrimaryButtonState extends State<PrimaryButton> {
   @override
   Widget build(BuildContext context) {
     return Container( // ------- button
         child: GestureDetector(
           onTap: () {

           },
           child: Container(
               width: double.infinity,
               height: SizeConfig.blockSizeVertical * 7,
               margin: EdgeInsets.all(5),
               decoration: BoxDecoration(
                 color: Color(0xff3f333f),
                 borderRadius: BorderRadius.all(Radius.circular(10.0)),
               ),
               child: Center(
                 child: Text(
                   widget.text,
                   style: TextStyle(
                     //fontFamily: "FireSans",
                     decoration: TextDecoration.none,
                     fontSize: 20,
                     color: Colors.white,
                   ),
                 ),
               )
           ),
         )

     );
   }
 }

 class OutlineButton extends StatefulWidget {
  OutlineButton({Key key, this.text});

  final String text;

   @override
   _OutlineButtonState createState() => _OutlineButtonState();
 }

 class _OutlineButtonState extends State<OutlineButton> {
   final AuthService _auth = AuthService();

   @override
   Widget build(BuildContext context) {
     return Container( // ------- button
         child: GestureDetector(
           onTap: () async {
             // dynamic because it could return null or AuthService
              dynamic result = await _auth.signInGuest();
              if (result == null) {
                print('error signing in');
              } else {
                print('signed in:\n' + result);
              }
           },
           child: Container(
               width: double.infinity,
               height: SizeConfig.blockSizeVertical * 7,
               margin: EdgeInsets.all(5),
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.all(Radius.circular(10.0)),
                 border: Border.all(color: Colors.black, width: 2,),
               ),
               child: Center(
                 child: Text(
                   widget.text,
                   style: TextStyle(
                     //fontFamily: "FireSans",
                     decoration: TextDecoration.none,
                     fontSize: 20,
                     color: Colors.black,
                   ),
                 ),
               )
           ),
         )

     );
   }
 }

 