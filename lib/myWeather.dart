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
