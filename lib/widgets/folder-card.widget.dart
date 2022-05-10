import 'package:flutter/material.dart';
import 'package:younes_mobile/models/gallery-item.dart';

class FolderTile extends StatelessWidget {
  GalleryItem item;
  FolderTile(this.item);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 40),
          child: ListTile(
            onTap: () {},
            leading: const SizedBox(
              width: 50,
              height: 30,
              child: Icon(
                Icons.folder,
                size: 68,
              ),
            ),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(62, 24, 20, 0),
              child: Text(item.name),
            ),
          ],
        ),
      ],
    );
  }
}
