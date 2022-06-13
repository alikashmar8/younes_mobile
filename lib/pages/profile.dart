import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:younes_mobile/main.dart';
import 'package:younes_mobile/models/user.model.dart';
import 'package:younes_mobile/pages/auth/login.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfileState();
}

class ProfileState extends State<ProfilePage> {
  late User user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      user = Get.find<User>(tag: 'user');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blue[400],
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Profile',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            ),

            // child: Text('Profile:')),
            // Spacer(flex: 5,),
            Text('Name: ${user.name}', style: const TextStyle(fontSize: 20)),
            Text('Email: ${user.email}', style: const TextStyle(fontSize: 20)),
            MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.all(12),
                color: Colors.lightBlue,
                child: const Text("Log out",
                    style: TextStyle(color: Colors.white)),
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
          ],
        ),
      ),
    );
  }
}
