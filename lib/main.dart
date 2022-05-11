// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:younes_mobile/pages/auth/login.dart';
import 'package:younes_mobile/pages/home.dart';


final storage = FlutterSecureStorage();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  Future<String> get jwtOrEmpty async {
    var jwt = await storage.read(key: "access_token");
    if (jwt == null) return "";
    return jwt;
  }

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Mobile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
          future: jwtOrEmpty,
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              // ignore: curly_braces_in_flow_control_structures
              return Scaffold(
                body: Expanded(
                  child: const Center(
                    child: CircularProgressIndicator(),
                 ),
                )
              );
            if (snapshot.data != "") {
              var str = snapshot.data.toString();
              var jwt = str.split(".");
              if (jwt.length != 3) {
                return LoginPage();
              } else {
                var payload = json.decode(
                    ascii.decode(base64.decode(base64.normalize(jwt[1]))));
                if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
                    .isAfter(DateTime.now())) {
                  return HomePage(str.toString(), payload);
                } else {
                  return LoginPage();
                }
              }
            } else {
              return LoginPage();
            }
          }),
    );
  }
}
