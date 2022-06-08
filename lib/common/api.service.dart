// ignore_for_file: avoid_renaming_method_parameters, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:younes_mobile/common/api.constants.dart';
import 'package:younes_mobile/common/custom-exceptions.dart';
import 'package:younes_mobile/main.dart';
import 'package:younes_mobile/widgets/dialogs.dart';

import 'base-api.service.dart';

class ApiService extends BaseApiService {
  @override
  Future getResponse(String url) async {
    String access_token = await storage.read(key: 'access_token') ?? '';
    dynamic responseJson;
    try {
      final http.Response response =
          await http.get(Uri.parse(apiUrl + url), headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
        'Charset': 'utf-8',
        'Authorization': 'Bearer ' + access_token,
      });
      print(response.body);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future postResponse(String url, Map<String, String?> JsonBody) async {
    String access_token = await storage.read(key: 'access_token') ?? '';
    dynamic responseJson;
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Accept': 'application/json',
      'Charset': 'utf-8',
    };
    headers['Authorization'] = 'Bearer ' + access_token;
    try {
      final http.Response response = await http.post(Uri.parse(apiUrl + url),
          headers: headers, body: jsonEncode(JsonBody));
      print('response.body.toString: ' + response.body.toString());
      responseJson = returnResponse(response);
    } on SocketException {
      Get.defaultDialog(
        title: 'No Internet Connection',
        content: const Text('Please check your internet connection'),
        confirm: FlatButton(
          child: const Text('Ok'),
          onPressed: () {
            Get.back();
          },
        ),
      );
      throw FetchDataException('No Internet Connection');
    } on HandshakeException {
      Get.defaultDialog(
        title: 'Server Error',
        content: const Text('Error communicating with server'),
        confirm: FlatButton(
          child: const Text('Ok'),
          onPressed: () {
            Get.back();
          },
        ),
      );
      throw FetchDataException('Session Expired');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    var body = jsonDecode(response.body);
    String message = '';
    if (body != null && response.statusCode > 299) {
      message = body['message'];
    } else {
      message = 'Error';
    }
    try {
      switch (response.statusCode) {
        case 201:
        case 200:
          dynamic responseJson = body;
          return responseJson;
        case 400:
          Get.defaultDialog(
            title: 'Bad Request',
            content: Text(message),
            confirm: FlatButton(
              child: const Text('Ok'),
              onPressed: () {
                Get.back();
              },
            ),
          );
          throw BadRequestException(response.body.toString());
        case 401:
        case 403:
          Get.defaultDialog(
            title: 'Unauthorized',
            content: Text(message),
            confirm: FlatButton(
              child: const Text('Ok'),
              onPressed: () {
                Get.back();
              },
            ),
          );
          throw UnauthorizedException(response.body.toString());
        case 404:
          Get.defaultDialog(
            title: 'Not Found',
            content: Text(message),
            confirm: FlatButton(
              child: const Text('Ok'),
              onPressed: () {
                Get.back();
              },
            ),
          );
          throw FetchDataException(response.body.toString());
        case 500:
        default:
          ViewDialogs.showMessageDialog(
              'Error connecting to server', response.body);
          throw FetchDataException(
              'Error occurred while communication with server' +
                  ' with status code : ${response.statusCode}');
      }
    } on FormatException catch (e) {
      Get.defaultDialog(
        title: 'Error',
        content: const Text('Unable to parse server response'),
        confirm: FlatButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('OK'),
        ),
      );
      throw FetchDataException('Unable to parse server response, ' +
          ' with status code : ${response.statusCode}');
    }
  }

  Future<int> deleteResponse(String url) async {
    String access_token = await storage.read(key: 'access_token') ?? '';
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Accept': 'application/json',
      'Charset': 'utf-8',
    };
    headers['Authorization'] = 'Bearer ' + access_token;
    try {
      final http.Response response =
          await http.delete(Uri.parse(apiUrl + url), headers: headers);
      print('response.body.toString: ' + response.body.toString());
      return response.statusCode;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on HandshakeException {
      throw FetchDataException('Session Expired');
    }
  }

  Future<int> putResponse(String id, dynamic data) async {
    String access_token = await storage.read(key: 'access_token') ?? '';
    Map<String, String> headers = {};
    headers['Authorization'] = 'Bearer ' + access_token;
    try {
      final http.Response response = await http.put(
        Uri.parse(apiUrl + id),
        headers: headers,
        body: data,
      );
      print('response.body.toString: ' + response.body.toString());
      return response.statusCode;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on HandshakeException {
      throw FetchDataException('Session Expired');
    }
  }
}
