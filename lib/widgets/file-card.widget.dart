// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:younes_mobile/models/gallery-item.dart';

class FileCard extends StatelessWidget {
  GalleryItem item;
  FileCard(this.item);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.all(10),
      child: SizedBox(
          height: height * 0.3,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Stack(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      child: SizedBox(
                        //height: height * 0.2,
                        width: double.infinity,
                        child: Image.network(
                          item.image.toString(),
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    item.name,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Price: ' + item.price.toString()),
                )
              ],
            ),
          )),
    );
  }
}
