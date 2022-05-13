// ignore_for_file: type_init_formals, use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/utils.dart';
import 'package:younes_mobile/common/api.service.dart';
import 'package:younes_mobile/common/base-api.service.dart';
import 'package:younes_mobile/controllers/gallery-items.controller.dart';
import 'package:younes_mobile/models/gallery-item.dart';
import 'package:younes_mobile/widgets/dialogs.dart';
import 'package:younes_mobile/widgets/file-card-2.dart';
import 'package:younes_mobile/widgets/file-card.widget.dart';
import 'package:younes_mobile/widgets/folder-card.widget.dart';

class GalleyWidget extends StatefulWidget {
  // const GalleyWidget({Key? key}) : super(key: key);
  var jwt;
  var payload;

  GalleyWidget(String jwt) {
    this.jwt = jwt;
  }

  @override
  State<GalleyWidget> createState() => _GalleyWidgetState(jwt);
}

class _GalleyWidgetState extends State<GalleyWidget> {
  // List<GalleryItem> items = [];
  _GalleyWidgetState(this.jwt);
  var jwt;
  bool isLoading = true;
  final GalleryItemsController _controller = Get.put(GalleryItemsController());
  final BaseApiService _baseApiService = ApiService();

  bool tappedYes = false;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
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
                      return AlignedGridView.count(crossAxisCount:  2, 
                        itemCount: _controller.itemsList.length,
                          
                       itemBuilder: 
                            (BuildContext context, int index) {
                              return _controller.itemsList[index].type == "folder"
                                  ? FolderTile(
                                      _controller.itemsList[index],
                                    )
                                  : FileCard(
                                      _controller.itemsList[index],
                                    );
                            },
                      );
                    }
                      //       staggeredTileBuilder: (int index) =>
                      //           StaggeredTile.count(1, 1),
                      //       mainAxisSpacing: 10,
                      //       crossAxisSpacing: 10,
                      //       padding: const EdgeInsets.all(10),
                      //     );
                      //  )
                      // return StaggeredGrid.count(crossAxisCount: _controller.itemsList.length,
                      //     mainAxisSpacing: 2, crossAxisSpacing: 4, children: [

                      //   for (var item in _controller.itemsList.value)
                      //     if (item.type == 'folder')
                      //       FolderTile(
                      //          item,
                      //       )
                      //     else
                      //       FileTile(
                      //         item,
                      //       ),
                            
                        // for (var item in _controller.itemsList.value)
                        //   if (!item.isFolder)
                        //     FileTile(
                        //       item
                        //     ),
                      // ]); 
                    //   GridView.builder(
                    //     itemCount: _controller.itemsList.length,
                    //     itemBuilder: (context, index) =>
                    //         _controller.itemsList[index].type == 'folder'
                    //             ? FolderTile(_controller.itemsList[index])
                    //             : FolderTile(_controller.itemsList[index]),
                    //     gridDelegate:
                    //         const SliverGridDelegateWithFixedCrossAxisCount(
                    //       crossAxisCount: 2,
                    //       childAspectRatio: 2,
                    //     ),
                    //   );
                    // }
                  }),
                ),
              ],
            ));
  }

  void initializeData() {
    _baseApiService.getResponse('businesses', jwt).then((galleries) {
      setState(() {
        isLoading = false;
      });
    }).catchError((error) {
      print('error catched');
      setState(() {
        print(error.toString());
        Get.defaultDialog(
          title: 'Error',
          content: Text(error.toString()),
          actions: [
            FlatButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Ok'),
            ),
          ],
        );
        isLoading = false;
      });
    });
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
