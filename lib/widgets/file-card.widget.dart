// ignore_for_file: file_names, prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:younes_mobile/common/api.constants.dart';
import 'package:younes_mobile/models/gallery-item.model.dart';
import 'package:younes_mobile/pages/gallery-item-details.dart';
import 'package:younes_mobile/services/gallery-items.service.dart';

typedef void StringCallback(String val);

class FileCard extends StatefulWidget {
  GalleryItem item;
  final StringCallback callback;

  FileCard(this.item, this.callback);

  @override
  State<FileCard> createState() => _FileCardState();
}

class _FileCardState extends State<FileCard> {
  GalleryItemsService galleryItemsService = GalleryItemsService();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GalleryItemDetailsPage(
                item: widget.item,
              ),
            ),
          ).then((value) => widget.callback(value));
          ;
        },
        child: SizedBox(
            height: height * 0.3,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                        child: SizedBox(
                          height: height * 0.17,
                          width: double.infinity,
                          child: Hero(
                            tag: widget.item.id,
                            child: Image.network(
                              widget.item.image.toString(),
                              fit: BoxFit.fill,
                              color: widget.item.quantity! < 1
                                  ? Colors.black.withOpacity(0.5)
                                  : null,
                              colorBlendMode: BlendMode.darken,
                            ),
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
                                  child: Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                                )
                              : InkWell(
                                  onTap: () async {
                                    int status =
                                        await galleryItemsService.makefavorite(
                                            widget.item.id.toString());
                                    if (status <= 299) {
                                      setState(() {
                                        widget.item.isFavorite = true;
                                      });
                                    } else {
                                      print('Error unfavoriting item');
                                    }
                                  },
                                  child: Icon(
                                    Icons.favorite_border,
                                    color: Colors.red,
                                  ),
                                ),
                        ),
                      ),
                      widget.item.quantity! < 1
                          ? Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                margin: EdgeInsets.only(top: height * 0.01),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: <Widget>[
                                    FittedBox(
                                      child: Icon(
                                        Icons.block,
                                        color: Colors.red,
                                        size: width * 0.3,
                                      ),
                                    ),
                                    Text(
                                      'Out of stock',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container()
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.item.name,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Price: ' + widget.item.price.toString()),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
