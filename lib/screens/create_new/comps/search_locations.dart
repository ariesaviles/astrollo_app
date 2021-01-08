import 'package:flutter/material.dart';
import 'package:astrollo_app/services/place_service.dart';

/*
  ? Builds page for Location search and shows Suggestions.
  Tutorial from: Yong Shean github: yshean
  * Contains the class for SearchLocation
 */
class SearchLocation extends SearchDelegate<Suggestion> {
  SearchLocation(this.sessionToken) {
    apiClient = PlaceApiProvider(sessionToken);
  }

  final sessionToken;
  PlaceApiProvider apiClient;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  } // buildAction

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        tooltip: 'Back',
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        }
    ) ;
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: query == ""
          ? null
          : apiClient.fetchSuggestions(query),
      builder: (context, snapshot) => query == ''
          ? Container(
            padding: EdgeInsets.all(16.0),
            child: Text('Enter your address'),
          )
          : snapshot.hasData
          ? ListView.builder(
            itemBuilder: (context, index) => ListTile(
              title:
                Text((snapshot.data[index] as Suggestion).description),
                onTap: () {
                  close(context, snapshot.data[index] as Suggestion);
                },
            ),
        itemCount: snapshot.data.length,
      )
          : Container(child: Text('Loading..?.')),
    );
  }
}