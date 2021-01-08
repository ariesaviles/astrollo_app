import 'package:astrollo_app/screens/create_new/comps/search_locations.dart';
import 'package:astrollo_app/services/place_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:astrollo_app/configs/size_config.dart';
import 'package:uuid/uuid.dart';

class LocField extends StatefulWidget {
  const LocField({
    Key key,
    this.hint,
    this.controller,
    this.latContr,
    this.lngContr,
  }) : super(key: key);

  final String hint;
  final TextEditingController controller;
  //double lat, lng;
  final TextEditingController latContr;
  final TextEditingController lngContr;

  @override
  _LocFieldState createState() => _LocFieldState();
}

class _LocFieldState extends State<LocField> {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: SizeConfig.screenWidth * 0.3,
          child: Text('Birth Location', style: TextStyle(fontSize: 15),),
        ), // * label container
        Container(height: SizeConfig.screenHeight * 0.05,
            child: VerticalDivider(color: Colors.grey)
        ),
        customTextField(),
      ],
    );
  } // build

  /// textfield with variations: Date, Location, Default(i.e. Name); for Time see ../time_field.dart
  /// param: String
  Container customTextField() {
    bool check = true;
    return Container(
      width: SizeConfig.screenWidth * 0.50,
      child: TextField(
        controller: widget.controller,
        //readOnly: true,
        textAlign: TextAlign.right,
        onTap: () async {
          // ? generate new session token here
          final sessionToken = Uuid().v4();
          final Suggestion result = await showSearch(
              context: context,
              delegate: SearchLocation(sessionToken)
          ); // * result
          // ? text then displayed in TextField
          if (result != null) {
            check = false;
            final placeDetails = await PlaceApiProvider(sessionToken).getPlaceDetailFromId(result.placeId);
            setState(() {
              widget.controller.text = result.description;
              widget.latContr.text = placeDetails.lat.toString();
              widget.lngContr.text = placeDetails.long.toString();
            });
          }
        },
        decoration: InputDecoration(
          hintText: check ? widget.hint : '',
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
