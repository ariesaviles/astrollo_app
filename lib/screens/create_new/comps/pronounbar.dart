import 'package:astrollo_app/configs/size_config.dart';
import 'package:astrollo_app/screens/create_new/create_chart.dart';
import 'package:flutter/material.dart';

class PronounBar extends StatelessWidget {
  const PronounBar({
    Key key,
    this.onPressedP,
    this.selectedP,
  }) : super(key: key);

  final void Function(int selectedIndex) onPressedP;
  final int selectedP;

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _LeftButton(Text('he/him', textAlign: TextAlign.center, style: TextStyle(color: Colors.black)), 0),
        _MiddleButton(Text('she/her', textAlign: TextAlign.center, style: TextStyle(color: Colors.black)), 1),
        _MiddleButton(Text('they/them', textAlign: TextAlign.center, style: TextStyle(color: Colors.black)), 2),
        _RightButton(Text('other', textAlign: TextAlign.center, style: TextStyle(color: Colors.black)), 3),
      ],
    );
  } // build

  Widget _LeftButton(Text pronouns, int index) {
    return GestureDetector(
      onTap: () => onPressedP(index),
      child: Container(
        width: SizeConfig.blockSizeHorizontal * 22,
        height: SizeConfig.blockSizeVertical * 5,
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
        child: pronouns,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xff7c6e76)),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                topLeft: Radius.circular(10.0)
            ),
            color: selectedPronoun == index ? Colors.grey[400] : Colors.white
        ),
      ),

    );
  } // LEFT BUTTON
  Widget _MiddleButton(Text pronouns, int index) {
    return GestureDetector(
      onTap: () => onPressedP(index),
      child: Container(
        width: SizeConfig.blockSizeHorizontal * 22,
        height: SizeConfig.blockSizeVertical * 5,
        child: pronouns,
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xff7c6e76)),
            borderRadius: BorderRadius.only(

            ),
            color: selectedPronoun == index ? Colors.grey[400] : Colors.white
        ),
      ),

    );
  } // MIDDLE BUTTON
  Widget _RightButton(Text pronouns, int index) {
    return GestureDetector(
      onTap: () => onPressedP(index),
      child: Container(
        width: SizeConfig.blockSizeHorizontal * 22,
        height: SizeConfig.blockSizeVertical * 5,
        child: pronouns,
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xff7c6e76)),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10.0),
                topRight: Radius.circular(10.0)
            ),
            color: selectedPronoun == index ? Colors.grey[400] : Colors.white
        ),
      ),

    );
  } // RIGHT BUTTON
} // PronounBar