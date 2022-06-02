// ignore_for_file: file_names, use_key_in_widget_constructors, unused_local_variable, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:younes_mobile/common/api.constants.dart';
import 'package:younes_mobile/models/gallery-item.dart';
import 'package:younes_mobile/services/gallery-items.service.dart';

class GalleryItemDetailsPage extends StatefulWidget {
  final GalleryItem item;
  const GalleryItemDetailsPage({required this.item});

  @override
  State<GalleryItemDetailsPage> createState() => _GalleryItemDetailsPageState();
}

class _GalleryItemDetailsPageState extends State<GalleryItemDetailsPage> {
  GalleryItemsService galleryItemsService = GalleryItemsService();
  late GalleryItem item;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: Center(child: SpinKitSpinningLines(color: Colors.blue)),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(item.name),
            ),
            body: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: GridTile(
                    child: Container(
                      child: Hero(
                        tag: item.id,
                        transitionOnUserGestures: true,
                        child: Image(
                          height: MediaQuery.of(context).size.height / 3 - 30,
                          image: NetworkImage(
                            '${baseUrl}${item.image}',
                          ),
                          fit: BoxFit.contain,
                          color: item.quantity! < 1
                              ? Colors.black.withOpacity(0.7)
                              : null,
                          colorBlendMode: BlendMode.darken,
                        ),
                      ),
                    ),
                    footer: Container(
                      color: Colors.white,
                      child: ListTile(
                        leading: Text(
                          item.name,
                          style: const TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                        title: Text(
                          "price: " + (item.price).toString(),
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 2.0,
                  color: Colors.black,
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Description:  ',
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          item.description ?? '',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 2.0, color: Colors.black),
                // Row(
                //   children: [
                //     Expanded(
                //       child: MaterialButton(
                //         onPressed: () {
                //           showDialog(
                //               context: context,
                //               builder: (context) {
                //                 return AlertDialog(
                //                   title: Text("Buy"),
                //                   content: Text("How many do you want to buy?"),
                //                   actions: <Widget>[
                //                     MaterialButton(
                //                       onPressed: () {
                //                         Navigator.of(context).pop(context);
                //                       },
                //                       child: Text("Close"),
                //                     )
                //                   ],
                //                 );
                //               });
                //         },
                //         color: Colors.white,
                //         elevation: 0.2,
                //         child: Row(
                //           children: <Widget>[
                //             Expanded(
                //                 child: Text(
                //               "Buy",
                //               style: TextStyle(color: Colors.grey),
                //             )),
                //             Expanded(child: Icon(Icons.arrow_drop_down))
                //           ],
                //         ),
                //       ),
                //     ),
                //     Expanded(
                //       child: MaterialButton(
                //         onPressed: () {
                //           showDialog(
                //               context: context,
                //               builder: (context) {
                //                 return AlertDialog(
                //                   title: Text("Rent"),
                //                   content: Text("How many do you want to rent?"),
                //                   actions: <Widget>[
                //                     MaterialButton(
                //                       onPressed: () {
                //                         Navigator.of(context).pop(context);
                //                       },
                //                       child: Text("Close"),
                //                     )
                //                   ],
                //                 );
                //               });
                //         },
                //         color: Colors.white,
                //         elevation: 0.2,
                //         child: Row(
                //           children: <Widget>[
                //             Expanded(
                //                 child: Text(
                //               "Rent",
                //               style: TextStyle(color: Colors.grey),
                //             )),
                //             Expanded(child: Icon(Icons.arrow_drop_down))
                //           ],
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // Divider(
                //   height: 2.0,
                //   color: Colors.black,
                // ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(children: [
                    Expanded(
                      child: Text('Created by: ' + item.createdBy!.name),
                    )
                  ]),
                ),
                const Divider(
                  height: 2.0,
                  color: Colors.black,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(children: [
                    Expanded(
                      child: Text('Updated by: ' +
                          (item.updatedBy != null ? item.updatedBy!.name : '')),
                    )
                  ]),
                ),
                const Divider(
                  height: 2.0,
                  color: Colors.black,
                ),
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        child: Text(
                          (item.quantity! > 0 ? 'Sell' : 'Out of stock'),
                          style: const TextStyle(color: Colors.white),
                        ),
                        onPressed: item.quantity! <= 0
                            ? null
                            : () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Sell"),
                                        content: const Text(
                                            "Are you sure you want to sell this item?"),
                                        actions: <Widget>[
                                          MaterialButton(
                                            onPressed: () async {
                                              Navigator.of(context)
                                                  .pop(context);
                                            },
                                            child: const Text("Cancel"),
                                          ),
                                          MaterialButton(
                                            onPressed: () async {
                                              setState(() {
                                                isLoading = true;
                                              });
                                              var res =
                                                  await galleryItemsService
                                                      .sellItem(item.id, 1);
                                              setState(() {
                                                isLoading = false;
                                              });
                                              Navigator.of(context)
                                                  .pop(context);
                                              initializeData();
                                            },
                                            child: const Text("Confirm"),
                                          )
                                        ],
                                      );
                                    });
                              },
                        color: Colors.red,
                        disabledColor: Colors.grey,
                        elevation: 0.2,
                      ),
                    ),
                    const IconButton(
                        icon: Icon(
                          Icons.share,
                          color: Colors.red,
                        ),
                        onPressed: null),
                    const IconButton(
                        icon: Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: null),
                  ],
                ),
                const Divider(
                  height: 2.0,
                  color: Colors.black,
                ),

                //When products are called from others
                /*Products()*/
              ],
            ));
  }

  Future<void> initializeData() async {
    setState(() {
      isLoading = true;
    });
    GalleryItem res =
        await galleryItemsService.getById(widget.item.id.toString());
    setState(() {
      item = res;
      isLoading = false;
    });
  }
}
