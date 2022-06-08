// ignore_for_file: non_constant_identifier_names

abstract class BaseApiService {

  Future<dynamic> getResponse(String url);
  Future<dynamic> postResponse(String url, Map<String, String> jsonBody);
}
