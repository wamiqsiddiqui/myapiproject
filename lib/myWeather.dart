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
  void _patchPost() async {
    final Map<String, dynamic> updatedData = {
      'title': 'Patched Title',
    };

    final patchMethodUrl =
        Uri.https('jsonplaceholder.typicode.com', '/posts/1');
    final response = await http.patch(
      patchMethodUrl,
      headers: {'Content-Type': 'application/json'},
      body: convert.jsonEncode(updatedData),
    );

    if (response.statusCode == 200) {
      // Successful patch
      print('Post patched successfully!');
    } else {
      // Error handling
      print('Error patching post. Status code: ${response.statusCode}');
      print('Error message: ${response.body}');
    }
  }

  void _deletePost() async {
    final deleteMethodUrl =
        Uri.https('jsonplaceholder.typicode.com', '/posts/1');
    final response = await http.delete(
      deleteMethodUrl,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Successful delete
      print('Post deleted successfully!');
    } else {
      // Error handling
      print('Error deleting post. Status code: ${response.statusCode}');
      print('Error message: ${response.body}');
    }
  }

  void _updatePost() async {
    final Map<String, dynamic> updatedData = {
      'title': 'Updated Title',
      'body': 'Updated Body',
      'userId': 1,
    };

    final putMethodUrl = Uri.https('jsonplaceholder.typicode.com', '/posts/1');
    final response = await http.put(
      putMethodUrl,
      headers: {'Content-Type': 'application/json'},
      body: convert.jsonEncode(updatedData),
    );

    if (response.statusCode == 200) {
      // Successful update
      print('Post updated successfully!');
    } else {
      // Error handling
      print('Error updating post. Status code: ${response.statusCode}');
      print('Error message: ${response.body}');
    }
  }

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
