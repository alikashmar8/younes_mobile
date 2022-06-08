// ignore_for_file: non_constant_identifier_names, unused_local_variable, avoid_init_to_null

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:spinner_input/spinner_input.dart';
import 'package:image_picker/image_picker.dart';
import 'package:younes_mobile/common/api.constants.dart';
import 'package:younes_mobile/main.dart';
import 'package:younes_mobile/common/base-api.service.dart';
import 'package:http/http.dart' as http;
// hide MultipartFile;
import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:path/path.dart';
import 'package:async/async.dart';

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
    File? imageFile = null;
    final ImagePicker _picker = ImagePicker();

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
          'type': 'item',
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
                      imageFile = image;
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
          ]),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                print(data);
                print('_image');
                if (_image != null) {
                  data['image'] = _image;
                }
                String access_token =
                    await storage.read(key: 'access_token') ?? '';
                var uri = Uri.parse(apiUrl + 'gallery-items/files');
                var dio = Dio();
                // ignore: deprecated_member_use
                var stream =
                    http.ByteStream(DelegatingStream.typed(_image!.openRead()));
                // get file length
                var length = await _image!.length();

                // try {
                ///[1] CREATING INSTANCE
                var dioRequest = Dio();
                // dioRequest.options.baseUrl = '<YOUR-URL>';

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
                  'quantity': data['quantity'].toString()
                });

                var response = await dioRequest.post(
                  uri.toString(),
                  data: formData,
                );
                final result = json.decode(response.toString());
                print(result);
                // } catch (err) {
                //   print('ERROR  $err');
                //   print(err);
                // }

                // BASE64
                // read image bytes from disk as a list
                // List<int> imageBytes = File(imageFile?.path ?? "").readAsBytesSync();
                // convert that list to a string & encode the as base64 files
                // String imageString = "data:image/jpeg;base64," + base64Encode(imageBytes);
                // apiCall(imageString);

                //[3] ADDING EXTRA INFO
                // var formData = new FormData.fromMap({
                //   'name': data['name'],
                //   'price': data['price'],
                //   'description': data['description'],
                //   'quantity': data['quantity'].toString()
                // });

                //[4] ADD IMAGE TO UPLOAD
                var file = await MultipartFile.fromFile(
                  _image!.path,
                  filename: basename(_image!.path),
                  // contentType: Dio().MediaType("image", basename(image.path))
                );

                // formData.files.add(MapEntry('image', file));

                //[5] SEND TO SERVER
                //   var response = await dioRequest.post(
                //     uri.toString(),
                //     data: formData,
                //   );
                //   final result = json.decode(response.toString())['result'];
                // } catch (err) {
                //   print('ERROR  $err');
                //   print(err);
                // }

                // var request = http.MultipartRequest("POST", uri);
                // request.fields['name'] = data['name'];
                // request.fields['price'] = data['price'];
                // request.fields['description'] = data['description'];
                // request.fields['quantity'] = data['quantity'].toString();
                // request.files.add(await http.MultipartFile.fromPath(
                //   'image',
                //   _image!.path,
                //   filename: basename(_image!.path),
                // ));
                // request.headers.addAll({
                //   'Authorization': 'Bearer $access_token',
                //   'Accept': 'application/json',
                //   'Content-Type': 'application/x-www-form-urlencoded'
                // });
                // print(request.files);
                // // var response = await dio.post(
                // //   uri.toString(),
                // //   data: request.fields,
                // //   options: Options(
                // //     headers: request.headers,
                // //     method: 'POST',
                // //   ),
                // //   onSendProgress: (int sent, int total) {
                // //     print((sent / total * 100).toStringAsFixed(0) + '%');
                // //   },
                // // );
                // var res = await request.send();
                // // .then((response) {
                //   // if (response.statusCode == 200) print("Uploaded!");
                //   print(res.statusCode);
                //   var response = await http.Response.fromStream(res);
                //   print(response.body);

                // });
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
