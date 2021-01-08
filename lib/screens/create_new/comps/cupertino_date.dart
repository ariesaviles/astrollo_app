import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class DatePick extends StatefulWidget {
  @override
  _DatePickState createState() => _DatePickState();
}

class _DatePickState extends State<DatePick> {
  bool _showTitle = true;

  DateTimePickerLocale _locale = DateTimePickerLocale.en_us;
  List<DateTimePickerLocale> _locales = DateTimePickerLocale.values;

  String _format = 'yyyy-MM-dd';
  TextEditingController _formatContr = TextEditingController();

  DateTime _dateTime;

  @override
  void initState() {
    super.initState();
    _formatContr.text = _format;
    _dateTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    // ? create locale list w radios
    List<Widget> radios = List<Widget>();
    _locales.forEach((locale) {
      radios.add(Container(
        margin: EdgeInsets.only(right: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Radio(
              value: locale,
              groupValue: _locale,
              onChanged: (value) {
                setState(() {
                  _locale = value;
                });
              },
            ),
            Text(locale.toString().substring(locale.toString().indexOf('.') + 1))
          ],
        ),
      ));
    }); // _locales.forEach

    return Container();
  }
}
