// ignore_for_file: avoid_renaming_method_parameters, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:younes_mobile/common/custom-exceptions.dart';
import 'package:younes_mobile/widgets/dialogs.dart';

import 'base-api.service.dart';

class ApiService extends BaseApiService {
  @override
  Future getResponse(String url, String access_token) async {
    dynamic responseJson;
    try {
      final http.Response response =
          await http.get(Uri.parse(baseUrl + url), headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
        'Charset': 'utf-8',
        'Authorization': 'Bearer ' + access_token,
      });
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future postResponse(
      String url, Map<String, String> JsonBody, String? access_token) async {
    dynamic responseJson;
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Accept': 'application/json',
      'Charset': 'utf-8',
    };
    if (access_token != null) {
      headers['Authorization'] = 'Bearer ' + access_token;
    }
    try {
      final http.Response response = await http.post(Uri.parse(baseUrl + url),
          headers: headers, body: jsonEncode(JsonBody));
      print('response.body.toString: ' + response.body.toString());
      responseJson = returnResponse(response);
    } on SocketException {
      Get.defaultDialog(
        title: 'No Internet Connection',
        content: const Text('Please check your internet connection'),
        confirm: FlatButton(
          child: Text('Ok'),
          onPressed: () {
            Get.back();
          },
        ),
      );
      throw FetchDataException('No Internet Connection');
    }
    on HandshakeException {
      Get.defaultDialog(
        title: 'Server Error',
        content: const Text('Error communicating with server'),
        confirm: FlatButton(
          child: Text('Ok'),
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
    try {
      switch (response.statusCode) {
        case 201:
        case 200:
          String responseapi = response.body.toString().replaceAll("\n", "");
          var jsonsDataString = response.body.toString();
          dynamic responseJson = jsonDecode(jsonsDataString);
          return responseJson;
        case 400:
          ViewDialogs.showMessageDialog('Bad Request', response.body);
          throw BadRequestException(response.body.toString());
        case 401:
        case 403:
          ViewDialogs.showMessageDialog('Unauthorized', response.body);
          throw UnauthorizedException(response.body.toString());
        case 404:
          ViewDialogs.showMessageDialog('Request not found', response.body);
          throw UnauthorizedException(response.body.toString());
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
          child: Text('OK'),
        ),
      );
      throw FetchDataException(
          'Unable to parse server response, ' +
              ' with status code : ${response.statusCode}');
    }
  }
}
