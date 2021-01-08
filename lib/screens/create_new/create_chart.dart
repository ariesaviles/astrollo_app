import 'package:astrollo_app/screens/create_new/comps/location_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:astrollo_app/screens/create_new/comps/pronounbar.dart';
import 'package:astrollo_app/screens/create_new/comps/time_field.dart';
import 'package:astrollo_app/screens/create_new/comps/name_field.dart';
import 'package:astrollo_app/screens/create_new/comps/date_field.dart';
import 'package:astrollo_app/configs/size_config.dart';

// ! TODO:
// * gather all variables in Strings
// ! call immanuel api and display results on CardPage

int selectedPronoun, selectedTime, intUnknownTime;

class CreateChartPage extends StatefulWidget {
  @override
  _CreateChartPage createState() => _CreateChartPage();
}

class _CreateChartPage extends State<CreateChartPage> {
  String tempTime;

  final _nameController = TextEditingController();

  final _locationController = TextEditingController();
  final _latController = TextEditingController();
  final _lngController = TextEditingController();
  //double lat, lng;

  final _dateController = TextEditingController();

  bool _unknownTime = false;
  final _timeController = TextEditingController();

  final _chartFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _locationController.dispose();
    _latController.dispose();
    _lngController.dispose();

    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () { // ? used to hide keyboard when user taps somewhere else
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xffb9b0aa),
        appBar: AppBar(
            backgroundColor: Color(0xff130713),
            title: Text('Create new chart')
        ),
        body: Container(
          color: Colors.white,
          height: SizeConfig.screenHeight * 1,
          child: Form(
            key: _chartFormKey,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical * 1, horizontal: SizeConfig.blockSizeHorizontal * 5,),
              child: ListView( // ********************* Form Begin *********************
                //shrinkWrap: true,
                  children: <Widget> [
                    Container(           // padding
                      height: SizeConfig.screenHeight * 0.02,
                      width: SizeConfig.screenWidth * 1,
                      color: Colors.white,
                    ),
                    Container(           // padding
                      height: SizeConfig.screenHeight * 0.03,
                      width: SizeConfig.screenWidth * 0.95,
                      color: Colors.white,
                      child: Text('Personal Information', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
                    ),
                    Container(           // padding
                      height: SizeConfig.screenHeight * 0.01,
                      width: SizeConfig.screenWidth * 1,
                      color: Colors.white,
                    ),
                    NameField( // * --------------------- Name ----------------
                      controller: _nameController,
                      hint: 'Angela Davis',
                    ),
                    Divider(color: Colors.black,),
                    Container(           // padding
                      height: SizeConfig.screenHeight * 0.01,
                      color: Colors.white,
                    ),
                    Container( // * --------------------- Pronoun Bar ---------------
                        color: Colors.white,
                        child: PronounBar(
                          onPressedP: onPressedPronoun,
                          selectedP: selectedPronoun,
                        )
                    ),
                    Container(           // padding
                      height: SizeConfig.screenHeight * 0.04,
                      width: SizeConfig.screenWidth * 1,
                      color: Colors.white,
                    ),
                    Container(           // padding
                      height: SizeConfig.screenHeight * 0.03,
                      width: SizeConfig.screenWidth * 0.95,
                      color: Colors.white,
                      child: Text('Chart Information', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
                    ),
                    Container(           // padding
                      height: SizeConfig.screenHeight * 0.02,
                      width: SizeConfig.screenWidth * 1,
                      color: Colors.white,
                    ),

                    DateField( // * --------------------- DOB -------------------
                        hint: 'YYYY-MM-DD',
                        label: Text('Date of Birth', style: TextStyle(fontSize: 15),),
                        controller: _dateController,
                    ),
                    Divider(color: Colors.black,),

                    LocField( // * --------------------- Location ----------------
                      controller: _locationController,
                      hint: 'Birmingham, AL',
                      latContr: _latController,
                      lngContr: _lngController,
                    ),
                    Divider(color: Colors.black,),
                    TimeField( // * --------------------- Time ----------------
                      controller: _timeController,
                      onPressedTime: onPressedTime, // AM is selectedTime 0
                      selectedTime: selectedTime,
                    ),
                    Divider(color: Colors.black),
                    Row(       // * ------------------ Unknown Birth Time
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget> [

                          Text('or', style: TextStyle(color: Colors.grey[600], fontSize: 12),),
                          Text(' Unknown Birth Time', style: TextStyle(color: Colors.black, fontSize: 15)),
                          Checkbox(
                            activeColor: Color(0xffBDBDBD),
                            value: _unknownTime,
                            onChanged: (value) => setState(() {
                              _unknownTime = value;
                              if (value == true) {
                                // ? if unknownTime is checked, set time to 00:00
                                // ? if there is already a value, save it to temp
                                //tempTime = _timeController.text;
                                _timeController.text = '00:00';
                              }
                            }),
                          ),
                          Container(width: SizeConfig.blockSizeHorizontal * 1,)
                        ]
                    ),
                    Divider(color: Colors.black,),

                    Container(           // padding
                      height: SizeConfig.screenHeight * 0.02,
                      width: SizeConfig.screenWidth * 1,
                      color: Colors.white,
                    ),
                    RaisedButton(  // ********************* Button *********************
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      color: Color(0xff3f333f),
                      child: const Text('Submit', style: TextStyle(color: Colors.white),),
                      onPressed: () {
                        processData();
                        SnackBar(content: Text('Processing Data'));
                      },
                    ),
                  ]
              ),

            ),

          ),

        ),


      ),
    );

  } // build

  void onPressedPronoun(int index) {
    setState(() {
      selectedPronoun = selectedPronoun == index ? null : index;
    });
  } // onPressed

  void onPressedTime(int index) {
    setState(() {
      selectedTime = selectedTime == index ? null : index;
    });
  } // onPressed

  void processData(){
    // * --------------------------------------- process name and pronouns
    String nameData, pronoun1, pronoun2;
    print("name and pronouns: " + _nameController.text);
    if (selectedPronoun == 0) {
      print("he/him");
    } else if (selectedPronoun == 1) {
      print("she/her");
    } else if (selectedPronoun == 2) {
      print("they/them");
    } else if (selectedPronoun == 3) {
      print("other");
    } else {
      print("unknown pronuons");
    }

    // * --------------------------------------- process date
    print("datecontroller: " + _dateController.text);

    // * --------------------------------------- process location
    print("loccontroller text: " + _locationController.text);
    print("lat and long: " + _latController.text + _lngController.text);

    // * --------------------------------------- process time
    print("timecontroller: " + _timeController.text);

    if (_unknownTime == false) { // if user knows birth time
      if (selectedTime == null) { // validation
        // please specify AM or PM
        print("specifiy AM or PM");
      } else if (selectedTime == 0) { // if AM
        print("AM");
      } else if (selectedTime == 1) { // if PM
        print("PM");
      } else { // default statement
        print("OOM");
      }
    } else { // if unknown birth time
      print("unknown");
    }
}


} // _CreateChartPage


