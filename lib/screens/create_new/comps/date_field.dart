import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:astrollo_app/configs/size_config.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

/// Custom TextField used for in "Create a new chart" page.
/// Includes: black label, divider, textfield
/// Constructor: label: Text, hint: String

class DateField extends StatefulWidget {
  const DateField({
    Key key,
    this.label,
    this.hint,
    this.controller,
  }) : super(key: key);

  final Text label;
  final String hint;
  final TextEditingController controller;

  @override
  _DateFieldState createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  bool _showTitle = true;
  final _locController = TextEditingController();

  final maskDate = MaskTextInputFormatter(mask: "####-##-##", filter: {"#": RegExp(r'[0-9]')});
  DateTimePickerLocale _locale = DateTimePickerLocale.en_us;
  List<DateTimePickerLocale> _locales = DateTimePickerLocale.values;
  String _format = 'yyyy-MMMM-dd';
  TextEditingController _dateContr = TextEditingController();

  DateTime _dateTime;

  @override
  void initState() {
    super.initState();
    //_dateContr.text = _format;
    widget.controller.text = _format;
    _dateTime = DateTime.now();
  }

  @override
  void dispose() {
    _locController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: SizeConfig.screenWidth * 0.3,
          child: widget.label,
        ), // * label container
        Container(height: SizeConfig.screenHeight * 0.05,
            child: VerticalDivider(color: Colors.grey)
        ),
        customTextField(widget.hint),
      ],
    );
  } // build

  /// textfield with variations: Date, Location, Default(i.e. Name); for Time see ../time_field.dart
  /// param: String
  Container customTextField(String hint) {

    if (hint == "YYYY-MM-DD") {
      return Container(
        width: SizeConfig.screenWidth * 0.50,
        child: TextField(
          //inputFormatters: [maskDate],
          //keyboardType: TextInputType.number,
          textAlign: TextAlign.right,
          readOnly: true,
          controller: widget.controller,
          onTap: _showDatePicker,
          decoration: InputDecoration(
            hintText: hint,
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
    } else {
      return Container(
        width: SizeConfig.screenWidth * 0.50,
        child: TextFormField(
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            hintText: hint,
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

  String MIN_DATE = '0000-01-01';
  String MAX_DATE = '2030-01-01';

  void _showDatePicker() {
    DatePicker.showDatePicker(
      context,
      onMonthChangeStartWithFirstDate: true,
      pickerTheme: DateTimePickerTheme(
        showTitle: _showTitle,
        confirm: Text('Select', style: TextStyle(color: Colors.red)),
        cancel: Icon(Icons.clear),
      ),
      minDateTime: DateTime.parse(MIN_DATE),
      maxDateTime: DateTime.parse(MAX_DATE),
      initialDateTime: _dateTime,
      dateFormat: _format,
      locale: _locale,
      //onClose: () => print("----- onClose -----"),
      onCancel: () => print('onCancel'),
      onChange: (dateTime, List<int> index) {
        setState(() {
          _dateTime = dateTime;

        });
      },
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          _dateTime = dateTime;
          //_dateContr.text = _dateTime.toString().substring(0, 10);
          widget.controller.text = _dateTime.toString().substring(0, 10);
        });
      },
    );
  }
}
