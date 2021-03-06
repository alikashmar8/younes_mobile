// ignore_for_file: non_constant_identifier_names, unused_local_variable, avoid_init_to_null

import 'dart:convert';
import 'dart:io';

// hide MultipartFile;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:younes_mobile/common/api-endpoints.dart';
import 'package:younes_mobile/common/api.constants.dart';
import 'package:younes_mobile/common/api.service.dart';
import 'package:younes_mobile/main.dart';
import 'package:younes_mobile/models/gallery-item.model.dart';

enum ViewDialogsAction { yes, no }

class ViewDialogs {
  static ApiService apiService = ApiService();
  static Future<ViewDialogsAction?> showOkCancelDialog(
    BuildContext context,
    String title,
    String message,
  ) async {
    final action = await showDialog<ViewDialogsAction>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop()),
          FlatButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop()),
        ],
      ),
    );
    return action;
  }

  static Future<ViewDialogsAction> addItemDialog(
      BuildContext context, String? parent_id) async {
    // double spinner = 0;
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    File? imageFile = null;
    final ImagePicker _picker = ImagePicker();
    String errors = '';
    bool isLoading = false;
    var height = MediaQuery.of(context).size.height;

    String? user = await storage.read(key: 'user');
    var business_id = json.decode(user!)['business_id'];

    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
        Map<String, dynamic> data = {
          'name': nameController.text,
          'price': priceController.text,
          'description': descriptionController.text,
          'quantity': 1,
          'type': 'item',
          'business_id': business_id,
          'parent_id': parent_id,
        };
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Add Item'),
          content: isLoading
              ? const SpinKitSpinningLines(
                  color: Colors.blue,
                )
              : SingleChildScrollView(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          children: [
                            FittedBox(
                              child: Row(
                                children: [
                                  const Text("Add an Image"),
                                  // const SizedBox(width: 5),
                                  IconButton(
                                    icon: const Icon(Icons.add_a_photo),
                                    iconSize: 20,
                                    color: Colors.blue,
                                    onPressed: () async {
                                      var image = await ImagePicker.pickImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 80,
                                      );
                                      setState(() {
                                        imageFile = image;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            imageFile == null
                                ? Container()
                                : Center(
                                    child: FittedBox(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        height: 50,
                                        child: Image.file(
                                          imageFile!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Name',
                          ),
                          controller: nameController,
                          onChanged: (value) {
                            data['name'] = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Name Cannot be empty!';
                            }
                          },
                          onSaved: (value) {
                            data['name'] = value;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Price',
                          ),
                          keyboardType: TextInputType.number,
                          controller: priceController,
                          onChanged: (value) {
                            data['price'] = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Price Cannot be empty!';
                            }
                          },
                          onSaved: (value) {
                            data['price'] = value;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              // const Text(
                              //   "Item Quantity",
                              // ),
                              // const SizedBox(width: 10),
                              // SpinnerInput(
                              //   middleNumberPadding:
                              //       const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              //   spinnerValue: spinner,
                              //   minValue: 0,
                              //   maxValue: 200,
                              //   onChange: (newValue) {
                              //     setState(() {
                              //       spinner = newValue;
                              //     });
                              //   },
                              // ),
                            ],
                          ),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Item Description',
                          ),
                          controller: descriptionController,
                          onChanged: (value) {
                            data['description'] = value;
                          },
                          onSaved: (value) {
                            data['description'] = value;
                          },
                        ),
                        errors.isNotEmpty
                            ? Text(
                                errors,
                                style: TextStyle(color: Colors.red),
                              )
                            : Container(),
                      ]),
                ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                setState(() {
                  errors = '';
                  isLoading = true;
                });
                if (imageFile == null) {
                  setState(() {
                    errors = 'Please add an image';
                    isLoading = false;
                  });
                  return;
                }
                if (nameController.text.isEmpty) {
                  setState(() {
                    errors = 'Please enter a name';
                    isLoading = false;
                  });
                  return;
                }
                if (priceController.text.isEmpty) {
                  setState(() {
                    errors = 'Please enter a price';
                    isLoading = false;
                  });
                  return;
                }

                String access_token =
                    await storage.read(key: 'access_token') ?? '';
                var uri = Uri.parse(apiUrl + 'gallery-items/files');

                // try {
                ///[1] CREATING INSTANCE
                var dioRequest = Dio();

                //[2] ADDING TOKEN
                dioRequest.options.headers = {
                  'Authorization': 'Bearer $access_token',
                  'Content-Type': 'application/x-www-form-urlencoded'
                };

                // FORM DATA
                String fileName = imageFile!.path.split('/').last;
                FormData formData = FormData.fromMap({
                  'image': await MultipartFile.fromFile(imageFile!.path,
                      filename:
                          fileName), // change 'image' to the field name in your request
                  'name': data[
                      'name'], // you can send other data in request if required
                  'price': data['price'],
                  'description': data['description'],
                  'quantity': data['quantity'].toString(),
                  'parent_id': data['parent_id'],
                });
                try {
                  var response = await dioRequest.post(
                    uri.toString(),
                    data: formData,
                  );
                  if (response.statusCode == 200 ||
                      response.statusCode == 201) {
                    print('item added');
                    print(response.data);
                    Navigator.of(context).pop(ViewDialogsAction.yes);
                  }
                } on DioError catch (e) {
                  print(e.response);
                  print(e.response.statusCode);
                  print(e.response.data);
                  dynamic server_errors =
                      json.decode(e.response.toString())['message'];
                  String message = '';
                  for (var error in server_errors) {
                    message += error.toString() + '. \n\n';
                  }
                  setState(() {
                    errors = message;
                    isLoading = false;
                  });
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      }),
    );
    return action;
  }

  static void showMessageDialog(String title, String body) {
    Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: <Widget>[
          FlatButton(
            child: Text("OK"),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  static addFolderDialog(BuildContext context, String? parent_id) async {
    TextEditingController nameController = TextEditingController();
    var _formKey;
    bool isLoading = false;
    String errors = '';
    String name = '';

    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                title: const Text('Add Folder'),
                content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Folder Name',
                        ),
                        controller: nameController,
                        onChanged: (value) {
                          name = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Name Cannot be empty!';
                          }
                        },
                        onSaved: (value) {
                          name = value!;
                        },
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      setState(() {
                        errors = '';
                        isLoading = true;
                      });
                      if (nameController.text.isEmpty) {
                        setState(() {
                          errors = 'Please enter folder name';
                          isLoading = false;
                        });
                        return;
                      }
                      var uri = Uri.parse(apiUrl + 'gallery-items/folders');
                      await apiService
                          .postResponse(galleryItemsEndpoint + 'folders', {
                        'name': name,
                        'parent_id': parent_id,
                      }).then((response) {
                        print('folder added');
                        print(response);
                        Navigator.of(context).pop(ViewDialogsAction.yes);
                      });
                    },
                    child: const Text('Add'),
                  )
                ],
              );
            }));
    return action;
  }

  static showItemDetailsDialog(BuildContext context, GalleryItem item) {
    Get.dialog(
      AlertDialog(
        title: Text(item.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(item.description ?? ''),
            Text(item.price.toString()),
            Text(item.quantity.toString()),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
