import 'package:flutter/material.dart';
import 'package:younes_mobile/models/gallery-item.dart';

class FolderCard extends StatelessWidget {
  GalleryItem item;
  FolderCard(this.item);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsets.all(10),
      child: SizedBox(
        height: height * 0.2,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
               SizedBox(
                  width: height * 0.16,
                  child: const FittedBox(
                    child: Icon(
                      Icons.folder_rounded,
                      // size: 50,
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(item.name),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    
  }
}
