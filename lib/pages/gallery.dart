// ignore_for_file: type_init_formals, use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:younes_mobile/models/gallery-item.dart';
import 'package:younes_mobile/services/gallery-items.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
        floatingActionButton: SizedBox(
          height: 40,
          width: 40,
          child: FloatingActionButton(
            backgroundColor: Colors.blue[500],
            onPressed: () => showMaterialModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
              ),
              builder: (context) => SingleChildScrollView(
                controller: ModalScrollController.of(context),
                child: Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [],
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("Items:",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                              ],
                            )),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("Total Amount:",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 10),
                                TextField(
                                    decoration: InputDecoration(
                                  hintText: "0",
                                  border: OutlineInputBorder(),
                                )),
                              ]),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("Additional Notes:",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 10),
                                TextField(
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                    )),
                              ]),
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FloatingActionButton.extended(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    backgroundColor: Colors.blue[400],
                                    label: Text(
                                      "Cancel",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  FloatingActionButton.extended(
                                    onPressed: null,
                                    backgroundColor: Colors.blue[400],
                                    label: Text(
                                      "Add",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ])),
                      ],
                    )),
              ),
            ),
            child: const Icon(
              Icons.add,
              size: 30,
            ),
          ),
        ),
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
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width - 100,
      padding: const EdgeInsets.fromLTRB(20, 5, 15, 5),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 10,
          child: Column(
            children: <Widget>[
              Row(children: [
                const Padding(padding: EdgeInsets.all(8)),
                Image.network(
                  item.image.toString(),
                  fit: BoxFit.fill,
                  height: 25,
                  width: 25,
                ),
              ]),
              Row(children: [
                const Padding(padding: EdgeInsets.all(8)),
                Text(
                  item.name,
                  style: const TextStyle(fontSize: 13),
                )
              ]),
              Row(children: [
                const Padding(padding: EdgeInsets.all(8)),
                Text(
                  "Quantity: " + item.quantity.toString(),
                  style: const TextStyle(fontSize: 11),
                )
              ]),
              //    onTap: () {
              //      Navigator.push(context, MaterialPageRoute(builder: (_) {
              //        return DetailScreen(item);
              //       }));
              //     },
              //   ),
            ],
          )),
    );
  }
}

class DetailScreen extends StatelessWidget {
  GalleryItem item;
  DetailScreen(this.item);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Image.network(
            item.image.toString(),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
