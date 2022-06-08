import 'package:younes_mobile/common/api.service.dart';
import 'package:younes_mobile/common/base-api.service.dart';

class AuthService {
  final BaseApiService _baseApiService = ApiService();

  Future<dynamic> attemptLogIn(String email, String password) async {
    var body = {
      'email': email,
      'password': password,
    };
    print('attempting LogIn' + body.toString());
    var response = await _baseApiService.postResponse('auth/login', body);
    print('response:');
    print(response);
    // print('response status: ' + response.statusCode.toString());
    // print('response body: ' + response.body.toString());
    if (response != null) {
      return response;
    }
    return null;
  }

  Future<int> attemptSignUp(String email, String password, String name) async {
    var body = {
      'email': email,
      'password': password,
      'name': name,
      "role": "ADMIN"
    };
    var response = await _baseApiService.postResponse('auth/register', body);
    return response['status'];
  }

  //   var res = await http.post(
  //       Uri.parse(
  //         "$SERVER_IP/auth/register",
  //       ),
  //       body: {
  //         "email": email,
  //         "password": password,
  //         "name": name,
  //         "role": "ADMIN"
  //       });
  //   print('Sign up res code');
  //   print(res.statusCode);
  //   print(res.body);
  //   return res.statusCode;
  // }
}
