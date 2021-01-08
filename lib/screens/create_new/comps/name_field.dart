import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:astrollo_app/configs/size_config.dart';

class NameField extends StatefulWidget {
  const NameField({
    Key key,
    this.hint,
    this.controller,
}) : super(key: key);

  final String hint;
  final TextEditingController controller;

  @override
  _NameFieldState createState() => _NameFieldState();
}

class _NameFieldState extends State<NameField> {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: SizeConfig.screenWidth * 0.3,
          child: Text('Full Name', style: TextStyle(fontSize: 15),),
        ), // * label container
        Container(height: SizeConfig.screenHeight * 0.05,
            child: VerticalDivider(color: Colors.grey)
        ),
        customTextField(),
      ],
    );
  }

  Container customTextField() {
    return Container(
      width: SizeConfig.screenWidth * 0.50,
      child: TextField(
        controller: widget.controller,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText: widget.hint ,
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
    );
  }


}
