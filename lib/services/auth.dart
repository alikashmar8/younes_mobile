import '../main.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<String?> attemptLogIn(String email, String password) async {
    var res = await http.post(Uri.parse("$SERVER_IP/auth/login"),
        body: {"email": email, "password": password});
    if (res.statusCode == 200 || res.statusCode == 201) return res.body;
    return null;
  }

  Future<int> attemptSignUp(String email, String password, String name) async {
    var res = await http.post(
        Uri.parse(
          "$SERVER_IP/auth/register",
        ),
        body: {
          "email": email,
          "password": password,
          "name": name,
          "role": "ADMIN"
        });
    return res.statusCode;
  }
}
