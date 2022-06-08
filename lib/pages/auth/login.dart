// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:younes_mobile/pages/home.dart';
import 'package:younes_mobile/services/auth.service.dart';
import '../../main.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginState();

  // Future<int> attemptSignUp(String email, String password) async {
  //   var res = await http.post(Uri.parse("$SERVER_IP/auth/register"),
  //       body: {"email": email, "password": password});
  //   return res.statusCode;
  // }
}

final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
AuthService authService = AuthService();
void displayDialog(context, title, text) => showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(title: Text(title), content: Text(text)),
    );

class LoginState extends State<LoginPage> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Log In"),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: new EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  children: <Widget>[
                    const Icon(
                      Icons.person,
                      color: Colors.lightBlue,
                      size: 100.0,
                    ),
                    new SizedBox(height: 35.0),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                      ),
                    ),
                    new SizedBox(height: 20.0),
                    TextFormField(
                      autofocus: false,
                      controller: _passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            semanticLabel: _obscureText
                                ? 'show password'
                                : 'hide password',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.all(12),
                        color: Colors.lightBlue,
                        child: const Text('Log In',
                            style: TextStyle(color: Colors.white)),
                        onPressed: () async {
                          var email = _emailController.text;
                          var password = _passwordController.text;
                          var res =
                              await authService.attemptLogIn(email, password);
                          if (res != null) {
                            var data = res;
                            var jwt = data['access_token'];
                            var user = data;
                            if (data != null) {
                              storage.write(
                                  key: 'user', value: json.encode(user));
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
                      ),
                    ),
                    // FlatButton(
                    //  onPressed: () async {
                    //   var email = _emailController.text;
                    //   var password = _passwordController.text;

                    //  if (email.length < 4)
                    //    displayDialog(context, "Invalid email",
                    //        "The email should be at least 4 characters long");
                    //  else if (password.length < 4)
                    //   displayDialog(context, "Invalid Password",
                    //       "The password should be at least 4 characters long");
                    // else {
                    //  var res = await authService.attemptSignUp(
                    //      email, password, 'admin');
                    //   if (res == 201)
                    //    displayDialog(context, "Success",
                    //       "The user was created. Log in now.");
                    //  else if (res == 409)
                    //    displayDialog(
                    //        context,
                    //        "That email is already registered",
                    //        "Please try to sign up using another email or log in if you already have an account.");
                    //  else {
                    //    displayDialog(context, "Error",
                    //        "An unknown error occurred.");
                    //    }
                    //  }
                    // },
                    //  child: Text("Sign Up"))
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
