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
            const SizedBox(
                height: 80,
                child: Icon(
                  Icons.supervised_user_circle,
                  size: 90,
                  color: Colors.blue,
                )),
            //SizedBox(height: 12.0),
            Text(user.name,
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                    color: Colors.orange)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 40.0),
                _name(),
                const SizedBox(height: 40.0),
                _email(),
                const SizedBox(height: 12.0),
                //    _mobile(),
                const SizedBox(height: 12.0),
                //    _birthDate(),
                const SizedBox(height: 12.0),
                //    _gender(),
                const SizedBox(height: 12.0),
              ],
            ),
            //Container(
            //  width: double.infinity,
            //  decoration: BoxDecoration(
            //    borderRadius: BorderRadius.circular(20),
            //    color: Colors.blue[400],
            //  ),
            //  child: const Center(
            //    child: Padding(
            //      padding: EdgeInsets.all(8.0),
            //     child: Text(
            //       'Profile',
            //       style: TextStyle(fontSize: 30),
            //       ),
            //     ),
            //   ),
            // ),

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

_name() {
  User user;
  return Row(children: <Widget>[
    _prefixIcon(Icons.people),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text('Name',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15.0,
                color: Colors.grey)),
        SizedBox(height: 1),
        //  Text(user.name),
      ],
    )
  ]);
}

_email() {
  User user;
  return Row(children: <Widget>[
    _prefixIcon(Icons.email),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text('Email',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15.0,
                color: Colors.grey)),
        SizedBox(height: 1),
        // Text(user.email),
      ],
    )
  ]);
}

_prefixIcon(IconData iconData) {
  return ConstrainedBox(
    constraints: const BoxConstraints(minWidth: 48.0, minHeight: 48.0),
    child: Container(
        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
        margin: const EdgeInsets.only(right: 8.0),
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
                bottomRight: Radius.circular(10.0))),
        child: Icon(
          iconData,
          size: 20,
          color: Colors.grey,
        )),
  );
}
