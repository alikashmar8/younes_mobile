import 'package:flutter/material.dart';
import 'package:spinner_input/spinner_input.dart';

enum ViewDialogsAction { yes, no }

class ViewDialogs {

  static Future<void> addItemDialog(BuildContext context) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => 
        AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Add Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Item Name',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Item Price',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Item Quantity',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Item Description',
                ),
              ),
            ]
          ),
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
    );
    return action;
  }
      
      // SingleChildScrollView(
      //   // controller: ModalScrollController.of(context),
      //   child: Scaffold(
      //     body: Container(
      //         margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Container(
      //               padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      //               child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: const [
      //                     Text("Name:",
      //                         style: TextStyle(
      //                             fontSize: 15, fontWeight: FontWeight.bold)),
      //                     SizedBox(height: 10),
      //                     TextField(
      //                         decoration: InputDecoration(
      //                       border: OutlineInputBorder(),
      //                     )),
      //                   ]),
      //             ),
      //             Container(
      //               padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      //               child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Text("Quantity:",
      //                         style: TextStyle(
      //                             fontSize: 15, fontWeight: FontWeight.bold)),
      //                     SizedBox(height: 10),
      //                     SpinnerInput(
      //                       spinnerValue: spinner,
      //                       minValue: 0,
      //                       maxValue: 200,
      //                       onChange: (newValue) {
      //                         // setState(() {
      //                         //   spinner = newValue;
      //                         // });
      //                       },
      //                     ),
      //                   ]),
      //             ),
      //             Container(
      //               padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      //               child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: const [
      //                     Text("Description:",
      //                         style: TextStyle(
      //                             fontSize: 15, fontWeight: FontWeight.bold)),
      //                     SizedBox(height: 10),
      //                     TextField(
      //                         maxLines: 3,
      //                         decoration: InputDecoration(
      //                           border: OutlineInputBorder(),
      //                         )),
      //                   ]),
      //             ),
      //             Container(
      //                 margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      //                 child: Row(
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     children: [
      //                       FloatingActionButton.extended(
      //                         onPressed: () {
      //                           Navigator.of(context).pop();
      //                         },
      //                         backgroundColor: Colors.blue[400],
      //                         label: Text(
      //                           "Cancel",
      //                           style: TextStyle(fontSize: 14),
      //                         ),
      //                       ),
      //                       SizedBox(width: 10),
      //                       FloatingActionButton.extended(
      //                         onPressed: null,
      //                         backgroundColor: Colors.blue[400],
      //                         label: Text(
      //                           "Add",
      //                           style: TextStyle(fontSize: 14),
      //                         ),
      //                       ),
      //                     ])),
      //           ],
      //         )),
      //   ),
      // ),
  //   );
  // }
}
