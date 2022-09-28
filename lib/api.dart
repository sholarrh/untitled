import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'Models/getclass.dart';
import 'Models/loginModel.dart';

class ApiDB extends ChangeNotifier {
  var token;

  Future<Model> get() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $token'
    };
    Options dio = Options();
    var url = Uri.https('reqres.in', 'api/unknown');
    // var url1 = Uri.parse('https://reqres.in/api/unknown');
    // var response = await Dio().get('https://reqres.in/api/users?page=2',
    //     options: Options(
    //       receiveTimeout: 10000,
    //       sendTimeout: 10000,
    //       method: 'GET',
    //     ));
    var response = await http.get(url, headers: requestHeaders);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    print(jsonDecode(response.body));
    var data = jsonDecode(response.body);
    var responsedata = getCLassModelFromJson(response.body);
    print(responsedata.data![3].name);
    print(data['data'][0]);
    return responsedata;
    // var data1 = responsedata.data![0].id;
    // print(await http.read(Uri.https('example.com', 'foobar.txt')));
  }

  Future<void> post() async {
    var url = Uri.https('reqres.in', 'api/users');
    var url1 = Uri.parse('https://reqres.in/api/users');
    try {
      var payload = {"name": "morpheus", "job": "leader"};
      var response = await http.post(url, body: jsonEncode(payload));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      var data = jsonDecode(response.body);
      print(data);
    } catch (e, s) {
      print(e);
      print(s);
    }

    // print(await http.read(Uri.https('example.com', 'foobar.txt')));
  }

  Future<void> put() async {
    var url = Uri.https('reqres.in', 'api/login');
    var url1 = Uri.parse('https://reqres.in/api/login');

    var payload = {"email": "eve.holt@reqres.in", "password": "cityslicka"};
    var response = await http.post(url, body: payload);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    token = LoginModel.fromJson(jsonDecode(response.body));
    notifyListeners();
    // print(await http.read(Uri.https('example.com', 'foobar.txt')));
  }

  Future<void> delete() async {
    var url = Uri.https('reqres.in', 'api/users/8889989898');
    var url1 = Uri.parse('https://reqres.in/api/users/2');

    // var payload = {
    //   "name": "morpheus",
    //   "job": "leader"
    // };
    var response = await http.delete(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    // print(await http.read(Uri.https('example.com', 'foobar.txt')));
  }
}
