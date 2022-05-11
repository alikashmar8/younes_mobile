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


  @override
  Widget build(BuildContext context) {
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
