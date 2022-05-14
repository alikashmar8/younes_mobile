// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spinner_input/spinner_input.dart';
import 'package:image_picker/image_picker.dart';
import 'package:younes_mobile/main.dart';

enum ViewDialogsAction { yes, no }

class ViewDialogs {
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

  static Future<void> addItemDialog(BuildContext context) async {
    // double spinner = 0;
    File? _image;
    String? user = await storage.read(key: 'user');
    var business_id = json.decode(user!)['business_id'];

    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
        TextEditingController nameController = TextEditingController();
        TextEditingController priceController = TextEditingController();
        TextEditingController descriptionController = TextEditingController();
        Map<String, dynamic> data = {
          'name': nameController.text,
          'price': priceController.text,
          'description': descriptionController.text,
          'quantity': 1,
          // 'image': _image,
          'business_id': business_id,
        };
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Add Item'),
          content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Row(
              children: [
                const Text("Add an Image"),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.add_a_photo),
                  iconSize: 30,
                  color: Colors.blue,
                  onPressed: () async {
                    var image = await ImagePicker.pickImage(
                      source: ImageSource.gallery,
                      maxHeight: 240.0,
                      maxWidth: 240.0,
                    );
                    setState(() {
                      _image = image;
                    });
                  },
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
          ]),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                print(data);
                print('_image');
                if (_image != null) {
                  data['image'] = _image;
                }
                print(data);
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

  static Future<void> cameraImage() async {}
}
