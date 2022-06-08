import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:younes_mobile/main.dart';
import 'package:younes_mobile/pages/auth/login.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfileState();
}

class ProfileState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.all(12),
            color: Colors.lightBlue,
            child: const Text("Log out", style: TextStyle(color: Colors.white)),
            onPressed: () async {
              storage.delete(key: "access_token");
              Navigator.pop(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            }

            //    () => Navigator.push(
            //    context,
            //    MaterialPageRoute(builder: (context) => LoginPage()),
            //  ),
            ),
      ),
    );
  }
}
