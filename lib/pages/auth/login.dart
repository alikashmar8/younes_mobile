// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:younes_mobile/pages/home.dart';
import 'package:younes_mobile/services/auth.service.dart';

import '../../main.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  AuthService authService = AuthService();

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  // Future<int> attemptSignUp(String email, String password) async {
  //   var res = await http.post(Uri.parse("$SERVER_IP/auth/register"),
  //       body: {"email": email, "password": password});
  //   return res.statusCode;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Log In"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'email'),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              FlatButton(
                  onPressed: () async {
                    var email = _emailController.text;
                    var password = _passwordController.text;
                    var res = await authService.attemptLogIn(email, password);
                    if (res != null) {
                      var data = res;
                      var jwt = data['access_token'];
                      var user = data;
                      if (data != null) {
                        storage.write(key: 'user', value: json.encode(user));
                      }
                      if (jwt != null) {
                        storage.write(key: "access_token", value: jwt);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomePage.fromBase64(jwt)));
                      } else {
                        displayDialog(context, "An Error Occurred",
                            "No account was found matching that email and password");
                      }
                    } else {
                      displayDialog(context, "An Error Occurred",
                          "No account was found matching that email and password");
                    }
                  },
                  child: Text("Log In")),
              FlatButton(
                  onPressed: () async {
                    var email = _emailController.text;
                    var password = _passwordController.text;

                    if (email.length < 4)
                      displayDialog(context, "Invalid email",
                          "The email should be at least 4 characters long");
                    else if (password.length < 4)
                      displayDialog(context, "Invalid Password",
                          "The password should be at least 4 characters long");
                    else {
                      var res = await authService.attemptSignUp(
                          email, password, 'admin');
                      if (res == 201)
                        displayDialog(context, "Success",
                            "The user was created. Log in now.");
                      else if (res == 409)
                        displayDialog(
                            context,
                            "That email is already registered",
                            "Please try to sign up using another email or log in if you already have an account.");
                      else {
                        displayDialog(
                            context, "Error", "An unknown error occurred.");
                      }
                    }
                  },
                  child: Text("Sign Up"))
            ],
          ),
        ));
  }
}
