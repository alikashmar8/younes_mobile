// ignore_for_file: file_names, use_key_in_widget_constructors, unused_local_variable, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:younes_mobile/common/api.constants.dart';
import 'package:younes_mobile/models/gallery-item.model.dart';
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
  Map<String, String> updatedItem = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: const Center(
              child: SpinKitSpinningLines(color: Colors.blue),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(item.name),
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Get.defaultDialog(
                      title: 'Edit',
                      content: Column(
                        children: [
                          TextField(
                            controller: TextEditingController(
                                text: updatedItem['name']),
                            onChanged: (value) {
                              updatedItem['name'] = value;
                            },
                          ),
                          TextField(
                            controller: TextEditingController(
                                text: updatedItem['price'].toString()),
                            onChanged: (value) {
                              updatedItem['price'] = value;
                            },
                          ),
                          TextField(
                            controller: TextEditingController(
                                text: updatedItem['description']),
                            onChanged: (value) {
                              updatedItem['description'] = value;
                            },
                          ),
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                          child: const Text('Cancel'),
                          onPressed: () => Get.back(),
                        ),
                        ElevatedButton(
                          child: const Text('Save'),
                          onPressed: () async {
                            int status = await galleryItemsService.updateFile(
                                item.id.toString(), updatedItem);
                            if (status <= 299) {
                              Get.snackbar(
                                'Success',
                                'Updated successfully',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.green,
                                borderRadius: 10,
                                margin: const EdgeInsets.all(10),
                                snackStyle: SnackStyle.FLOATING,
                                duration: const Duration(seconds: 2),
                              );
                              Navigator.of(context).pop();
                              initializeData();
                            } else {
                              Get.snackbar(
                                'Error',
                                'Failed to update',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                borderRadius: 10,
                                margin: const EdgeInsets.all(10),
                                snackStyle: SnackStyle.FLOATING,
                                duration: const Duration(seconds: 2),
                              );
                            }
                          },
                        ),
                      ],
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    Get.defaultDialog(
                      title: 'Delete',
                      content: Column(
                        children: [
                          Text(
                            'Are you sure you want to delete ' +
                                item.name +
                                '?',
                            style: const TextStyle(fontSize: 18),
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
                          const Text(
                            'This action cannot be undone.',
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
                        MaterialButton(
                          child: const Text('Cancel'),
                          onPressed: () => Get.back(),
                        ),
                        MaterialButton(
                            child: const Text('Delete'),
                            onPressed: () async {
                              // if(parent_id != null) {
                              int status = await galleryItemsService
                                  .deleteItem(item.id.toString());
                              if (status <= 299) {
                                Get.snackbar(
                                    'Success', 'Item deleted successfully',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.green,
                                    colorText: Colors.white,
                                    borderRadius: 10,
                                    margin: const EdgeInsets.fromLTRB(
                                        10, 0, 10, 100),
                                    animationDuration:
                                        const Duration(milliseconds: 500),
                                    duration: const Duration(seconds: 4),
                                    icon: const Icon(
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
                                    margin: const EdgeInsets.fromLTRB(
                                        10, 0, 10, 100),
                                    animationDuration:
                                        const Duration(milliseconds: 500),
                                    duration: const Duration(seconds: 4),
                                    icon: const Icon(
                                      Icons.error,
                                      color: Colors.white,
                                    ),
                                    isDismissible: true,
                                    snackStyle: SnackStyle.FLOATING);
                              }
                            }),
                      ],
                    );
                  },
                ),
              ],
            ),
            body: ListView(
              shrinkWrap: true,
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
                Container(
                  margin: const EdgeInsets.all(20),
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
                const Divider(height: 2.0, color: Colors.black),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Row(children: [
                    const Text(
                      'Created By:  ',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(item.createdBy!.name),
                    )
                  ]),
                ),
                const Divider(
                  height: 2.0,
                  color: Colors.black,
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Row(children: [
                    const Text(
                      'Updated By:  ',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
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
      updatedItem['name'] = res.name;
      updatedItem['description'] = item.description!;
      updatedItem['price'] = item.price.toString();
      updatedItem['quantity'] = item.quantity.toString();
      isLoading = false;
    });
  }
}
