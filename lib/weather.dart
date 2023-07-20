import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:myapiproject/models/Location.dart';

class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  bool isLoading = false;
  callApi() async {
    setState(() {
      isLoading = true;
    });
    var url =
        Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': '{http}'});
    var weatherUrl = Uri.https('api.open-meteo.com', '/v1/forecast', {
      'latitude': "52.52",
      "longitude": "52.52",
    });
    // var myapi = Uri.https('10.0.2.2:3001', '/api/items');
    // var publicApi = Uri.http("api.publicapis.org", '/entries');
    var ss = await http.post(publicApi,
        headers: {'Content-Type': 'application/json'},
        body: convert.jsonEncode(
          {
            "API": "Matssss",
            "Description": "Resource to help get pets adopted",
            "Auth": "apiKey",
            "HTTPS": true,
            "Cors": "yes",
            "Link": "https://www.adoptapet.com/public/apis/pet_list.html",
            "Category": "Animals"
          },
        ));
    if (ss.statusCode == 201) {
      print('Post request successful! Response: ${ss.body}');
    } else {
      print('Failed to make post request. Status Code: ${ss.statusCode}');
    }
    var response = await http.get(weatherUrl);
    setState(() {
      isLoading = false;
    });
    if (response.statusCode == 200) {
      Location jsonResponse =
          Location.fromMap(convert.jsonDecode(response.body));
      var itemCount = jsonResponse.generationTimeMs;
      print('Number of books about http: $itemCount.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // callApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
            child: Column(
          children: [
            if (isLoading) CircularProgressIndicator(),
            ElevatedButton(
              child: Text("Get Details"),
              onPressed: () {
                callApi();
              },
            ),
          ],
        )),
      ),
    );
  }
}