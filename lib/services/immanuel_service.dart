import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:core';

import 'package:astrollo_app/global_comps/planet_object.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Friend {
  Friend({this.asc, this.sun, this.moon,});
  final Planet asc, sun, moon;

}

class ImmanuelApiProvider {
  ImmanuelApiProvider();

  /*
    @param: All data will be POSTed as a string
   */
  Future<Friend> fetchFriend(String name, String pronoun1, String pronoun2,
      String lat, String lng, String time, String date) async {
    String system = "Placidus";

    // ? formats the url call to the API and contains the response
    final http.Response response = await http.post(
      'https://api.immanuel.app/chart/natal',
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String> {

        'latitude': lat,
        'longitude': lng,
        'birth_date': date,
        'birth_time': time,
        'house_system': system,
      })
    );


  }
}