// ignore: import_of_legacy_library_into_null_safe
import 'package:api_manager/api_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiRepository {
  final storage = FlutterSecureStorage();

  static final ApiRepository _instance = ApiRepository._internal();

  /// singleton api repository
  late ApiManager _apiManager;

  factory ApiRepository() {
    return _instance;
  }

  ApiRepository._internal() {
    _apiManager = ApiManager();
    _apiManager.options.baseUrl =
        'http://ip172-18-0-64-c9sit2s33d5g008makb0-3000.direct.labs.play-with-docker.com';

    _apiManager.options.connectTimeout = 100000;
    _apiManager.options.receiveTimeout = 100000;
    _apiManager.enableLogging(responseBody: true, requestBody: false);

    _apiManager.enableAuthTokenCheck(() async {
      var jwt = await storage.read(key: "jwt");
      if (jwt == null) return "";
      return jwt;
    });

  }
}
