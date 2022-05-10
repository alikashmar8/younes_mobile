// ignore_for_file: avoid_renaming_method_parameters, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:younes_mobile/common/custom-exceptions.dart';

import 'base-api.service.dart';

class ApiService extends BaseApiService {

  @override
  Future getResponse(String url, String access_token) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(baseUrl + url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + access_token,
        });
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future postResponse(String url, Map<String, String> JsonBody) async {
    dynamic responseJson;
    try {
      print('sending request to:  ' +Uri.parse(baseUrl + url).toString());
      final response =
          await http.post(Uri.parse(baseUrl + url), body: JsonBody);
      print('response: ' + response.toString());
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 201:
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.toString());
      case 401:
      case 403:
        throw UnauthorizedException(response.body.toString());
      case 404:
        throw UnauthorizedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while communication with server' +
                ' with status code : ${response.statusCode}');
    }
  }
}
