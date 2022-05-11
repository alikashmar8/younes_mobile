// ignore_for_file: type_init_formals, use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/utils.dart';
import 'package:younes_mobile/controllers/gallery-items.controller.dart';
import 'package:younes_mobile/models/gallery-item.dart';
import 'package:younes_mobile/widgets/dialogs.dart';
import 'package:younes_mobile/widgets/file-card.widget.dart';
import 'package:younes_mobile/widgets/folder-card.widget.dart';
import 'dart:io';

class GalleyWidget extends StatefulWidget {
  const GalleyWidget({Key? key}) : super(key: key);

  @override
  State<GalleyWidget> createState() => _GalleyWidgetState();
}

class _GalleyWidgetState extends State<GalleyWidget> {
  // List<GalleryItem> items = [];
  final GalleryItemsController _controller = Get.put(GalleryItemsController());

  bool tappedYes = false;

  @override
  void initState() {
    super.initState();
    // initializeData();
  }

  _GalleyWidgetState({this.onTap, this.imagePath});
  final Function()? onTap;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (imagePath != null) {
      return Card(
        child: Container(
          height: 300,
          padding: EdgeInsets.all(10.0),
          width: size.width * .70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            image: DecorationImage(
                fit: BoxFit.cover, image: FileImage(File(imagePath as String))),
          ),
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.redAccent,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(3.0, 3.0),
                      blurRadius: 2.0, 
                    )
                  ]
                ),
                child: IconButton(onPressed: (){
                print('icon press');
              }, icon: Icon(Icons.delete, color: Colors.white)),
              )
            ],
          ),
        ),
      );
    }

    return Card(
        elevation: 3,
        child: InkWell(
          onTap: this.onTap,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 25),
            width: size.width * .70,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Attach Picture',
                  style: TextStyle(fontSize: 17.0, color: Colors.grey[600]),
                ),
                Icon(
                  Icons.photo_camera,
                  color: Colors.indigo[400],
                )
              ],
            ),
          ),
        ));
    return Scaffold(
        floatingActionButton: SizedBox(
          height: 40,
          width: 40,
          child: FloatingActionButton(
            backgroundColor: Colors.blue[500],
            onPressed: () async {
              final action = await ViewDialogs.addItemDialog(
                context,
                // 'Subscription',
                // 'Waant to be notified about the '
                //     'upcoming events and shows? Please subscribe to '
                //     'our News Channel.',
              );
              // if (action == ViewDialogsAction.yes) {
              //   setState(() => tappedYes = true);
              // } else {
              //   setState(() => tappedYes = false);
              // }
            },
            child: const Icon(
              Icons.add,
              size: 30,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (_controller.isLoading.value) {
                  print("Loading...");
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return GridView.builder(
                    itemCount: _controller.itemsList.length,
                    itemBuilder: (context, index) =>
                        _controller.itemsList[index].type == 'folder'
                            ? FolderTile(_controller.itemsList[index])
                            : FileTile(_controller.itemsList[index]),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2,
                    ),
                  );
                }
              }),
            ),
          ],
        ));
  }

  // initializeData() async {
  //   items = await GalleryItemsService.getGalleryItems();
  //   setState(() {
  //     items = items;
  //   });
  // }
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
