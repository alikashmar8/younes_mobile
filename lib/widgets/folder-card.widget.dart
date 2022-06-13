import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:younes_mobile/models/gallery-item.model.dart';
import 'package:younes_mobile/pages/gallery.dart';
import 'package:younes_mobile/services/gallery-items.service.dart';

typedef void StringCallback(String val);

class FolderCard extends StatefulWidget {
  GalleryItem item;
  // Call back not used for now
  final StringCallback callback;
  FolderCard({required this.item, required this.callback});

  @override
  State<FolderCard> createState() => _FolderCardState();
}

class _FolderCardState extends State<FolderCard> {
  GalleryItemsService galleryItemsService = GalleryItemsService();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
              width: height * 0.13,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GalleryPage(
                        widget.item.id.toString(),
                      ),
                    ),
                  ).then((value) => widget.callback(value));
                  // Get.to(GalleryPage(item.id.toString()));
                  // callback(item.id.toString());
                },
                child: Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.17,
                      width: double.infinity,
                      child: const FittedBox(
                        child: Icon(
                          Icons.folder_rounded,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin: EdgeInsets.only(right: 5, top: 5),
                        child: widget.item.isFavorite
                            ? InkWell(
                                onTap: () async {
                                  int status = await galleryItemsService
                                      .unfavorite(widget.item.id.toString());
                                  if (status <= 299) {
                                    setState(() {
                                      widget.item.isFavorite = false;
                                    });
                                  } else {
                                    print('Error unfavoriting item');
                                  }
                                },
                                child: const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                              )
                            : InkWell(
                                onTap: () async {
                                  int status = await galleryItemsService
                                      .makefavorite(widget.item.id.toString());
                                  if (status <= 299) {
                                    setState(() {
                                      widget.item.isFavorite = true;
                                    });
                                  } else {
                                    print('Error unfavoriting item');
                                  }
                                },
                                child: const Icon(
                                  Icons.favorite_border,
                                  color: Colors.red,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(widget.item.name),
            ],
          ),
        ],
      ),
    );
  }
}
