import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'dart:convert' as convert;

class MyWeather extends StatefulWidget {
  const MyWeather({super.key});

  @override
  State<MyWeather> createState() => _MyWeatherState();
}

class _MyWeatherState extends State<MyWeather> {
  bool isLoading = true;
  void callPostApi() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

    // Replace the title, body, and userId with the desired values
    final Map<String, dynamic> data = {
      'title': 'wamiq',
      'body': 'bar',
      'userId': 1,
    };

    final headers = {
      'Content-type': 'application/json; charset=UTF-8',
    };

    try {
      final response = await http.post(url,
          headers: headers, body: convert.jsonEncode(data));

      if (response.statusCode == 201) {
        // Successful POST request
        final jsonResponse = convert.jsonDecode(response.body);
        print(jsonResponse);
      } else {
        // If the server responds with an error status code, handle it accordingly
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions that occurred during the POST request
      print('Error: $e');
    }
  }

  callApi() async {
    var url =
        Uri.https("www.googleapis.com", '/books/v1/volumes', {"q": "http"});
    var response = await http.get(url); //ruka wa hai
    print("response = ${convert.jsonDecode(response.body)}");
    setState(() {
      isLoading = false;
    });
    print("init");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callApi();
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather"),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Text("Api Response Completed"),
      ),
    );
  }
}
