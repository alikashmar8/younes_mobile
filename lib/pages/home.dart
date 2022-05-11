// ignore_for_file: use_key_in_widget_constructors, no_logic_in_create_state

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:younes_mobile/common/api.service.dart';
import 'package:younes_mobile/common/base-api.service.dart';

import 'gallery.dart';

class HomePage extends StatefulWidget {
  const HomePage(this.jwt, this.payload);

  factory HomePage.fromBase64(String jwt) {
    print('jwt');
    print(jwt);
    var payload = json.decode(
        ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1]))));
    print('payload');
    print(payload);
    return HomePage(jwt, payload);
  }
  final String jwt;
  final Map<String, dynamic> payload;

  @override
  State<HomePage> createState() => _MyHomePageState(jwt, payload);
}

class _MyHomePageState extends State<HomePage> {
  _MyHomePageState(this.jwt, this.payload) {
    listOfWidgets = [
      GalleyWidget(jwt),
      const Text('page 2'),
      const Text('page 3'),
      const Text('page 4'),
    ];
  }

  List<Widget> listOfWidgets = [];

  final String jwt;
  final Map<String, dynamic> payload;
  var currentIndex = 0;

  var listOfIcons = [
    Icons.home_rounded,
    Icons.favorite_rounded,
    Icons.settings_rounded,
    Icons.person_rounded,
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(child: listOfWidgets[currentIndex]),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(20),
        height: size.width * .155,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.15),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: size.width * .024),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(
                  () {
                    currentIndex = index;
                  },
                );
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 1500),
                    curve: Curves.fastLinearToSlowEaseIn,
                    margin: EdgeInsets.only(
                      bottom: index == currentIndex ? 0 : size.width * .029,
                      right: size.width * .0422,
                      left: size.width * .0422,
                    ),
                    width: size.width * .128,
                    height: index == currentIndex ? size.width * .014 : 0,
                    decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(10),
                      ),
                    ),
                  ),
                  Icon(
                    listOfIcons[index],
                    size: size.width * .076,
                    color: index == currentIndex
                        ? Colors.blueAccent
                        : Colors.black38,
                  ),
                  SizedBox(height: size.width * .03),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
