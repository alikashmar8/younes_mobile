// ignore_for_file: non_constant_identifier_names

abstract class BaseApiService {
  final String baseUrl =
      'http://ip172-18-0-58-c9tu8mg9jotg00bising-3000.direct.labs.play-with-docker.com/api/';
  final String apiUrl =
      'http://ip172-18-0-58-c9tu8mg9jotg00bising-3000.direct.labs.play-with-docker.com/api/';

  Future<dynamic> getResponse(String url, String access_token);
  Future<dynamic> postResponse(String url, Map<String, String> jsonBody);
}
