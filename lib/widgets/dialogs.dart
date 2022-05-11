import 'dart:io';
import 'package:flutter/material.dart';
import 'package:spinner_input/spinner_input.dart';
import 'package:image_picker/image_picker.dart';


enum ViewDialogsAction { yes, no }

class ViewDialogs {
  static Future<void> addItemDialog(BuildContext context) async {
    double spinner = 0;
    File _image;

    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SingleChildScrollView(
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Add Item'),
          content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Row(
              children: const [
                Text("Add an Image"),
                SizedBox(width: 10),
                ExpandIcon(
                  // Icons.add_a_photo,
                  size: 30,
                  onPressed: cameraImage,
                ),
              ],
            ),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Item Name',
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Item Price',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  const Text(
                    "Item Quantity",
                  ),
                  const SizedBox(width: 10),
                  SpinnerInput(
                    spinnerValue: spinner,
                    minValue: 0,
                    maxValue: 200,
                    onChange: (newValue) {
                      spinner = newValue;
                    },
                  ),
                ],
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Item Description',
              ),
            ),
          ]),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
    return action;
  }
  static Future<void> cameraImage(bool value) async {
    print("aaa");
    var image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 240.0,
      maxWidth: 240.0,
    );
  }
}
