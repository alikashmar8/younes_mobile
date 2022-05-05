import 'package:flutter/material.dart';
import 'package:younes_mobile/models/folder.dart';
import 'package:younes_mobile/models/item.dart';
import 'package:younes_mobile/services/folder.dart';
import 'package:younes_mobile/services/items.dart';

class GalleyWidget extends StatefulWidget {
  const GalleyWidget({Key? key}) : super(key: key);

  @override
  State<GalleyWidget> createState() => _GalleyWidgetState();
}

class _GalleyWidgetState extends State<GalleyWidget> {
  List<Folder> folders = [];
  List<Item> items = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //TODO: create list of folders and items as gallery, you can get items from services
      child: Text(folders.length.toString()),
    );
  }

  initializeData() async {
    folders = await FoldersService.getFolders();
    items = await ItemsService.getItems();
    setState(() {
      folders = folders;
      items = items;
    });
  }
}
