import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:myapiproject/models/Location.dart';
import 'package:myapiproject/models/WeatherModel.dart';

class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  bool isLoading = false;
  WeatherModel? weatherResponse = null;
  callApi() async {
    setState(() {
      isLoading = true;
    });
    // var url =
    //     Uri.http('www.googleapis.com', '/books/v1/volumes', {'q': '{http}'});
    var weatherUrl = Uri.https('api.open-meteo.com', '/v1/forecast', {
      'latitude': "52.52",
      "longitude": "52.52",
    });

    var response = await http.get(weatherUrl);
    setState(() {
      isLoading = false;
      if (response.statusCode == 200) {
        weatherResponse =
            WeatherModel.fromMap(convert.jsonDecode(response.body));
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    });
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
            if (weatherResponse != null)
              Text("Timezone from Api = : ${weatherResponse!.timezone}"),
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
