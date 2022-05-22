// ignore_for_file: type_init_formals, use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors, non_constant_identifier_names, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
  List<GalleryItem> items = [];

  String _string = '';
  GalleyWidgetState(this.parent_id);
  String? parent_id;
  final GalleryItemsService _galleryItemsService = GalleryItemsService();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getItems();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: SpinKitSpinningLines(color: Colors.blue))
        : Scaffold(
            floatingActionButton: SizedBox(
              height: 40,
              width: 40,
              child: FloatingActionButton(
                backgroundColor: Colors.blue[500],
                onPressed: () async {
                  final action = await ViewDialogs.addItemDialog(
                    context,
                    parent_id,
                  );
                  print('action:');
                  print(action);
                  if (action == ViewDialogsAction.yes) {
                    setState(() {
                      isLoading = true;
                      items = [];
                    });
                    getItems();
                  }
                },
                child: const Icon(
                  Icons.add,
                  size: 30,
                ),
              ),
            ),
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
                                  print(val);
                                  setState(() => _string = val);
                                })
                            : FileCard(
                                items[index],
                              );
                      },
                    ))
                  ]),
          );
  }

  void getItems() {
    _galleryItemsService.getGalleryItems(parent_id).then((value) {
      setState(() {
        items = value;
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
