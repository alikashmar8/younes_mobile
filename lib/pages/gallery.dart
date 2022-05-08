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
    return Container(
      //TODO: create list of folders and items as gallery, you can get items from services
      child: Text(items.length.toString()),
    );
  }

  initializeData() async {
    items = await GalleryItemsService.getGalleryItems();
    setState(() {
      items = items;
    });
  }
}
