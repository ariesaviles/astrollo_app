import 'package:astrollo_app/configs/theme_config.dart';
import 'package:astrollo_app/screens/create_new/comps/name_field.dart';
import 'package:astrollo_app/configs/size_config.dart';
import 'package:astrollo_app/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
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
  
  double _loginWidth = 0;
  double _textOpacity = 0;

  double _loginYOffset, _loginXOffset = 0;
  double _registerOffset = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeConfig().init(context);

    final test = TextEditingController();

    switch(_pageState) {
      case 0:
        // ? opacity for "Chart the stars
        _textOpacity = 1;
        
        _loginWidth = SizeConfig.screenWidth;
        _loginYOffset = SizeConfig.screenHeight;
        _loginXOffset = 0;
        _registerOffset = SizeConfig.screenHeight;
        break;
      case 1:

        _textOpacity = 0;
        
        _loginWidth = SizeConfig.screenWidth;
        _loginYOffset = SizeConfig.blockSizeVertical * 20;
        _loginXOffset = 0;
        _registerOffset = SizeConfig.screenHeight;
        break;
      case 2:

        _textOpacity = 0;
        _loginWidth = SizeConfig.screenWidth;
        _loginYOffset = SizeConfig.screenHeight;
        _loginXOffset = 0;
        _registerOffset = SizeConfig.blockSizeVertical * 20;
        break;
    }

    return Material(
      child: Stack(
        children: [
          Container(
            //margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * ),
            child: Image.asset("lib/assets/images/backgroundGradient.png",
              fit: BoxFit.cover,
              height: SizeConfig.screenHeight,
              width: double.infinity,
              alignment: Alignment.center,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 50),
            child: Align(
              alignment: FractionalOffset.topCenter,
              child: Container(
                child: Image.asset("lib/assets/images/iconTrans.png", scale: 2.5,),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 50),
            child: Align(
              alignment: FractionalOffset.topLeft,
              child: Container(
                child: Image.asset("lib/assets/icons/left-arrow.png", scale: 10),
              ),
            ),
          ),
          AnimatedContainer(
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(
              milliseconds: 1000,
            ),
            //color: _backgroundColor,
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

                    child: Column(
                      children: <Widget>[

                        Container(
                          height: SizeConfig.screenHeight / 5
                        ),
                        Container(
                          margin: EdgeInsets.all(30),
                          child: Text("Chart the stars\nabove our hearts.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Cagile",
                              decoration: TextDecoration.none,
                              fontSize: 35,
                              color: Colors.white.withOpacity(_textOpacity),
                            ),
                          ),
                        ),
                        Container( // *  ----------------------- button
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
                                  width: 250,
                                  height: SizeConfig.blockSizeVertical * 8,
                                  //margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(_textOpacity),
                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                    border: Border.all(color: Colors.white.withOpacity(_textOpacity), width: 1, style: BorderStyle.solid),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Create an Account",
                                      style: TextStyle(
                                        //fontFamily: "FireSans",
                                        decoration: TextDecoration.none,
                                        fontSize: 22,
                                        color: Colors.black.withOpacity(_textOpacity),
                                      ),
                                    ),
                                  )
                              ),
                            )
                        ), // button

                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Padding(
                            padding: EdgeInsets.only(bottom: 50),
                            child: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(text: "Already have an account? ", style: TextStyle(fontSize: 15, color: Colors.black.withOpacity(_textOpacity))),
                                  TextSpan(text: "Sign in",
                                      style: TextStyle(fontSize: 15, color: ThemeConfig.blue.withOpacity(_textOpacity)),
                                      recognizer: new TapGestureRecognizer()..
                                      onTap = () {
                                        setState(() {
                                          _pageState = 2;
                                        });
                                      }
                                  )
                                ],
                              ),
                            )
                        )
                    )
                ),
              ], // * layer 0
            ),
          ),
          GestureDetector( // ------------------------- Create Account Container -----------------------
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
                color: Colors.white.withOpacity(0.60),
                border: Border.all(color: Colors.white, width: 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                )
              ),
              transform: Matrix4.translationValues(_loginXOffset, _loginYOffset, 1),
              child: Column(
                children: <Widget> [
                  Container(height: SizeConfig.blockSizeVertical * 2),
                  initialTextField(test, "Name"),
                  //Container(height: SizeConfig.blockSizeVertical * 5),
                  initialTextField(test, "Phone"),
                  Container(height: SizeConfig.blockSizeVertical * 2),
                  //Divider(color: Colors.black, indent: 50, endIndent: 50,),

                  Container( // *  ----------------------- sign in button
                      child: GestureDetector(
                        onTap: () {

                        },
                        child: Container(
                            width: 175,
                            height: SizeConfig.blockSizeVertical * 7,
                            //margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.75),
                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                              border: Border.all(color: Colors.black, width: 1, style: BorderStyle.solid),
                            ),
                            child: Center(
                              child: Text(
                                "Create Account",
                                style: TextStyle(
                                  //fontFamily: "FireSans",
                                  decoration: TextDecoration.none,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            )
                        ),
                      )
                  ), // * sign in button

                  //Divider(color: Colors.black, indent: 70, endIndent: 70,)
                  Padding(
                    padding: const EdgeInsets.only(top: 21),
                    child: Divider(color: Colors.black, indent: 40, endIndent: 40,),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 21),
                    child: Text(
                      "Or continue with:",
                      style: TextStyle(
                          fontSize: 14, color: Colors.black54, fontWeight: FontWeight.w600),
                    ),
                  ),


                ]
              ), // * create new layer 1
            ),
          ),
          GestureDetector( // ------------------------- Log in Container -----------------------
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
          ), // * log in layer 2
        ],
      ),
    );
  }

  Widget initialTextField(TextEditingController contr, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: TextField(
        controller: contr,
        decoration: InputDecoration(
          labelText: hint,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
            ),
          ),
          //fillColor: Colors.green
        ),
        //keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          fontFamily: "FiraSans",
        ),
      ),
    );
  }

} // end of main class initalPage()
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

 