import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:younes_mobile/models/gallery-item.dart';
import 'package:younes_mobile/pages/gallery.dart';

typedef void StringCallback(String val);

class FolderCard extends StatelessWidget {
  GalleryItem item;
  // Call back not used for now
  final StringCallback callback;
  FolderCard({required this.item, required this.callback});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
               body:  GestureDetector(
                onTap: () {
                  print('going to parent: ${item.id}');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GalleryPage(
                        item.id.toString(),
                      ),
                    ),
                  );
                  // Get.to(GalleryPage(item.id.toString()));
                  // callback(item.id.toString());
                },
                child: const FittedBox(
                  child: Icon(
                    Icons.folder_rounded,
                    // size: 50,
                  ),
                ),
              )
        //  Row(
         //   mainAxisAlignment: MainAxisAlignment.center,
         //   children: <Widget>[
         //     Text(item.name),
         //   ],
         // ),
        );
   }
  }

