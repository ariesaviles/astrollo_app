import 'package:astrollo_app/configs/size_config.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TimeField extends StatelessWidget {
  const TimeField({
    Key key,
    this.controller,
    this.onPressedTime,
    this.selectedTime,
  }) : super(key: key);

  final void Function(int selectedIndex) onPressedTime;
  final int selectedTime;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final maskTime = MaskTextInputFormatter(mask: "##:##", filter: {"#": RegExp(r'[0-9]') });

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Container(
          width: SizeConfig.screenWidth * 0.3,
          child: Text('Birth Time', style: TextStyle(fontSize: 15),),
        ),
        Container(height: SizeConfig.screenHeight * 0.05, child: VerticalDivider(color: Colors.grey)),
        Container(
          width: SizeConfig.screenWidth * 0.21,
          child: TextField(
            inputFormatters: [maskTime],
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: '12:30',
              hintStyle: TextStyle(color: Colors.grey[400]),
              filled: true,
              fillColor: Colors.white,
              border: InputBorder.none,
              /*enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.grey),
                )*/
            ),
          ),
        ),
        Container(
          width: SizeConfig.screenWidth * 0.01,
        ),
        _leftButton(Text('AM', textAlign: TextAlign.center, style: TextStyle(color: Colors.black)), 0),
        _rightButton(Text('PM', textAlign: TextAlign.center, style: TextStyle(color: Colors.black)), 1),
      ],
    );
  }


  Widget _leftButton(Text pronouns, int index) {
    return GestureDetector(
      onTap: () => onPressedTime(index),
      child: Container(
        width: SizeConfig.blockSizeHorizontal * 14,
        height: SizeConfig.blockSizeVertical * 5,
        child: pronouns,
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                topLeft: Radius.circular(10.0)
            ),
            color: selectedTime == index ? Colors.grey[400] : Colors.white
        ),
      ),

    );
  } // LEFT BUTTON

  Widget _rightButton(Text pronouns, int index) {
    return GestureDetector(
      onTap: () => onPressedTime(index),
      child: Container(
        width: SizeConfig.blockSizeHorizontal * 14,
        height: SizeConfig.blockSizeVertical * 5,
        child: pronouns,
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10.0),
                topRight: Radius.circular(10.0)
            ),
            color: selectedTime == index ? Colors.grey : Colors.white
        ),
      ),

    );
  } // RIGHT BUTTON

} // end of _TimeField} // TimeBar