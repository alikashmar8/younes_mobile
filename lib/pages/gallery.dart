// ignore_for_file: type_init_formals, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:younes_mobile/models/gallery-item.dart';
import 'package:younes_mobile/services/gallery-items.dart';

class GalleyWidget extends StatefulWidget {
  const GalleyWidget({Key? key}) : super(key: key);

  @override
  State<GalleyWidget> createState() => _GalleyWidgetState();

}

class _GalleyWidgetState extends State<GalleyWidget> {
  List<GalleryItem> items = [];
  @override
  void initState() {
    super.initState();
    initializeData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GridView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) => items[index].type == 'folder'
              ? FolderTile(items[index])
              : FileTile(items[index]),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2,
          ),
        ),
      ),
    );
  }

  initializeData() async {
    items = await GalleryItemsService.getGalleryItems();
    setState(() {
      items = items;
    });
  }
}

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

class FileTile extends StatelessWidget {
  GalleryItem item;
  FileTile(this.item);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(7),
            child: Container(
              width: 300,
              height: 150,
              padding: const EdgeInsets.all(10.0),
              child: Card(
                semanticContainer: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 10,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Image.network(
                        item.image.toString(),
                        fit: BoxFit.fill,
                      ),
                    ),
                    Row(
                      children: [
                        Text(item.id),
                      ],
                    ),
                    Row(
                      children: [
                        Text(item.name),
                      ],
                    ),
                    Row(
                      children: [
                        Text(item.quantity.toString()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
