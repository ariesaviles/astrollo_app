import 'dart:convert';
import 'package:http/http.dart';

/*
  Parses through Places JSON. Tutorial from: Yong Shean github: yshean
  * Contains the class for Place, Suggestion, PlaceApiProvider
 */
class Place {
  double lat;
  double long;

  Place({
    this.lat,
    this.long,
  });

  @override
  String toString() {
    return 'Place(lat: $lat, long $long)';
  }
}

class Suggestion {
  final String placeId;
  final String description;
  bool empty;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }

  void notEmpty(bool _empty) {
    empty = _empty;
  }
} // Suggestion

class PlaceApiProvider {
  final client = Client();

  PlaceApiProvider(this.sessionToken);

  final sessionToken;

  static final String androidKey = 'AIzaSyCOfYpEc4OKmYCy6-HxlBIItvFxpR8Kb2k';
  static final String iosKey = 'AIzaSyDkoPUcgIvZUJ-FO2Ts5bs-13rHp_KxoKc';
  final apiKey = 'AIzaSyCOfYpEc4OKmYCy6-HxlBIItvFxpR8Kb2k'; // ! needs to be if android or ios

  Future<List<Suggestion>> fetchSuggestions(String input) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=geocode&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  } // fetchSuggestions

  Future<Place> getPlaceDetailFromId(String placeId) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=geometry&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(request);
    // ? test code
    // print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> result = json.decode(response.body);
      if (result['status'] == 'OK') {
        final place = Place();
          place.lat = result['result']['geometry']["location"]["lat"];
          place.long = result['result']['geometry']['location']['lng'];
          // ? test code
          // print("lat: " + place.lat.toString() + "\nlong: " + place.long.toString());
        return place;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
