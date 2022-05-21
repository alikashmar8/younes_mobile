// ignore_for_file: non_constant_identifier_names

abstract class BaseApiService {
  final String baseUrl =
      // 'http://localhost:3000/api/';
      'https://bndbc0qt41.execute-api.eu-west-1.amazonaws.com/prod/api/';
  // final String apiUrl = apiUrl;

  Future<dynamic> getResponse(String url, String access_token);
  Future<dynamic> postResponse(String url, Map<String, String> jsonBody, String? access_token);
}
