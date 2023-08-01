import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'dart:convert' as convert;

import 'package:myapiproject/models/SocialMediaPost.dart';

class MyWeather extends StatefulWidget {
  const MyWeather({super.key});

  @override
  State<MyWeather> createState() => _MyWeatherState();
}

class _MyWeatherState extends State<MyWeather> {
  bool isLoading = true;
  bool isSuccess = false;
  bool hasError = false;
  void callPostApi() async {
    // final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final postUrl = Uri.https('jsonplaceholder.typicode.com', '/posts');

    // Replace the title, body, and userId with the desired values

    SocialMediaPost socialMediaPost = SocialMediaPost(
        userId: 10, id: 20, title: "Facebook Post", body: "Cooking Recipe");
    Map<String, dynamic> socialMediaMappedData = socialMediaPost.toMap();
    final headers = {
      'Content-type': 'application/json; charset=UTF-8',
    };

    try {
      final response = await http.post(postUrl,
          headers: headers, body: convert.jsonEncode(socialMediaMappedData));

      setState(() {
        isLoading = false;
        if (response.statusCode == 201) {
          // Successful POST request
          final jsonResponse = convert.jsonDecode(response.body);
          print(jsonResponse);
          isSuccess = true;
        } else {
          // If the server responds with an error status code, handle it accordingly
          print('Error: ${response.statusCode}');
          hasError = true;
        }
      });
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
    callPostApi();
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
            : hasError
                ? Text("Api Failed")
                : isSuccess
                    ? Text("Api Response Completed Successfully")
                    : Text("Nothing"),
      ),
    );
  }
}
