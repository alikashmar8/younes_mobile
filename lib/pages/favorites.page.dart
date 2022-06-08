// ignore_for_file: type_init_formals, use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors, non_constant_identifier_names, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:younes_mobile/models/gallery-item.model.dart';
import 'package:younes_mobile/services/gallery-items.service.dart';
import 'package:younes_mobile/widgets/file-card.widget.dart';
import 'package:younes_mobile/widgets/folder-card.widget.dart';

class FavoritesPage extends StatefulWidget {
  FavoritesPage();

  @override
  State<StatefulWidget> createState() => GalleyWidgetState();

  static GalleyWidgetState? of(BuildContext context) =>
      context.findAncestorStateOfType<GalleyWidgetState>();
}

class GalleyWidgetState extends State<FavoritesPage> {
  List<GalleryItem> items = [];

  String _string = '';
  GalleyWidgetState();
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
                            : FileCard(items[index], (val) {
                                if (val == 'deleted') {
                                  getItems();
                                }
                              });
                      },
                    ))
                  ]),
          );
  }

  Future<void> getItems() async {
    var res = await _galleryItemsService.getFavorites();
    setState(() {
      items = res;
    });
  }

  Future<void> initData() async {
    setState(() {
      isLoading = true;
    });
    await getItems();
    setState(() {
      isLoading = false;
    });
  }
}
