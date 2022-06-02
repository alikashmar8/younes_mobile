// ignore_for_file: type_init_formals, use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors, non_constant_identifier_names, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:younes_mobile/models/gallery-item.dart';
import 'package:younes_mobile/services/gallery-items.service.dart';
import 'package:younes_mobile/widgets/dialogs.dart';
import 'package:younes_mobile/widgets/file-card.widget.dart';
import 'package:younes_mobile/widgets/folder-card.widget.dart';

class GalleryPage extends StatefulWidget {
  String? parent_id;
  GalleryPage(this.parent_id);

  @override
  State<StatefulWidget> createState() => GalleyWidgetState(parent_id);

  static GalleyWidgetState? of(BuildContext context) =>
      context.findAncestorStateOfType<GalleyWidgetState>();
}

class GalleyWidgetState extends State<GalleryPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<GalleryItem> items = [];

  String _string = '';
  GalleyWidgetState(this.parent_id);
  String? parent_id;
  GalleryItem? parent = null;
  final GalleryItemsService _galleryItemsService = GalleryItemsService();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: SpinKitSpinningLines(color: Colors.blue))
        : Scaffold(
            key: _scaffoldKey,
            appBar: parent_id != null
                ? AppBar(
                    title: Text(parent?.name ?? 'Gallery'),
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          Get.defaultDialog(
                            title: 'Delete',
                            content: Column(
                              children: [
                                Text(
                                  'Are you sure you want to delete ' +
                                      parent!.name +
                                      '?',
                                  style: TextStyle(fontSize: 18),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  textScaleFactor: 1.0,
                                  textDirection: TextDirection.ltr,
                                  locale: null,
                                  semanticsLabel: null,
                                  strutStyle: StrutStyle.disabled,
                                  textWidthBasis: TextWidthBasis.parent,
                                  textHeightBehavior: null,
                                ),
                                Text(
                                  'This action cannot be undone and all files inside this folder will be deleted.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.redAccent,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  textScaleFactor: 1.0,
                                  textDirection: TextDirection.ltr,
                                  locale: Locale('en', 'US'),
                                  semanticsLabel: 'Delete',
                                ),
                              ],
                            ),
                            actions: [
                              FlatButton(
                                child: Text('Cancel'),
                                onPressed: () => Get.back(),
                              ),
                              FlatButton(
                                  child: Text('Delete'),
                                  onPressed: () async {
                                    // if(parent_id != null) {
                                    int status = await _galleryItemsService
                                        .deleteItem(parent_id!);
                                    print('status:');
                                    print(status);
                                    if (status <= 299) {
                                      Get.snackbar('Success',
                                          'Item deleted successfully',
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Colors.green,
                                          colorText: Colors.white,
                                          borderRadius: 10,
                                          margin: EdgeInsets.fromLTRB(
                                              10, 0, 10, 100),
                                          animationDuration:
                                              Duration(milliseconds: 500),
                                          duration: Duration(seconds: 4),
                                          icon: Icon(
                                            Icons.check_box_rounded,
                                            color: Colors.white,
                                          ),
                                          isDismissible: true,
                                          snackStyle: SnackStyle.FLOATING);
                                      Navigator.of(context)
                                        ..pop('deleted')
                                        ..pop('deleted');
                                    } else {
                                      Get.back();
                                      Get.snackbar('Error',
                                          'Error occurred while deleting item',
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Colors.red,
                                          colorText: Colors.white,
                                          borderRadius: 10,
                                          margin: EdgeInsets.fromLTRB(
                                              10, 0, 10, 100),
                                          animationDuration:
                                              Duration(milliseconds: 500),
                                          duration: Duration(seconds: 4),
                                          icon: Icon(
                                            Icons.error,
                                            color: Colors.white,
                                          ),
                                          isDismissible: true,
                                          snackStyle: SnackStyle.FLOATING);
                                      // Get.back();

                                    }
                                  }),
                            ],
                          );
                        },
                      ),
                    ],
                  )
                : null,
            floatingActionButton: buildSpeedDial(),
            body: items.isEmpty
                ? Center(
                    child: Text(
                      'No items found!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Column(children: [
                    Expanded(
                        child: AlignedGridView.count(
                      crossAxisCount: 2,
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return items[index].type == "folder"
                            ? FolderCard(
                                item: items[index],
                                callback: (val) {
                                  if (val == 'deleted') {
                                    getItems();
                                  }
                                })
                            : FileCard(
                                items[index],
                              );
                      },
                    ))
                  ]),
          );
  }

  SpeedDial buildSpeedDial() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 28.0),
      backgroundColor: Colors.blue,
      visible: true,
      curve: Curves.bounceInOut,
      children: [
        SpeedDialChild(
          child: Icon(Icons.create_new_folder, color: Colors.white),
          backgroundColor: Colors.blue,
          onTap: () async {
            final action = await ViewDialogs.addFolderDialog(
              context,
              parent_id,
            );
            if (action == ViewDialogsAction.yes) {
              setState(() {
                isLoading = true;
                items = [];
              });
              getItems();
            }
          },
          label: 'Add Folder',
          labelStyle:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Colors.black,
        ),
        SpeedDialChild(
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Colors.blue[500],
          onTap: () async {
            final action = await ViewDialogs.addItemDialog(
              context,
              parent_id,
            );
            if (action == ViewDialogsAction.yes) {
              setState(() {
                isLoading = true;
                items = [];
              });
              getItems();
            }
          },
          label: 'Add Item',
          labelStyle:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Colors.black,
        ),
        SpeedDialChild(
          child: Icon(Icons.share, color: Colors.white),
          backgroundColor: Colors.blue,
          onTap: () => print('Pressed Code'),
          label: 'Share Active Items',
          labelStyle:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Colors.black,
        ),
      ],
    );
  }

  Future<void> getItems() async {
    var res = await _galleryItemsService.getGalleryItems(parent_id);
    setState(() {
      items = res;
    });
  }

  Future<void> initData() async {
    setState(() {
      isLoading = true;
    });
    if (parent_id != null) {
      GalleryItem res = await _galleryItemsService.getById(parent_id!);
      setState(() {
        parent = res;
      });
    }
    await getItems();
    setState(() {
      isLoading = false;
    });
  }
}
