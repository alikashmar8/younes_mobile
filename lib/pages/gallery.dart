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
          // ignore: unrelated_type_equality_checks
          itemBuilder: (context, index) => items[index].type == 'folder'
              ? FolderTile(index)
              : FileTile(index),
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
  const FolderTile(int index);
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
          children: const [
            Padding(
              padding: EdgeInsets.fromLTRB(62, 24, 20, 0),
              child: Text("folder"),
            ),
          ],
        ),
      ],
    );
  }
}

class FileTile extends StatelessWidget {
  const FileTile(int index);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: EdgeInsets.all(7),
          child: Container(
            width: 300,
            height: 200,
            padding: new EdgeInsets.all(10.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 10,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading:
                        Image.asset('https://picsum.photos/200/300/?random'),
                    title: const Text(""),
                  ),
                  Row(
                    children: const [
                      Text("id"),
                    ],
                  ),
                  Row(
                    children: const [
                      Text("name"),
                    ],
                  ),
                  Row(
                    children: const [
                      Text("quantity"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
