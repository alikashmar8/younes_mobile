
import 'package:flutter/material.dart';
import 'package:younes_mobile/models/gallery-item.dart';

class FileTile extends StatelessWidget {
  GalleryItem item;
  FileTile(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width - 100,
      padding: const EdgeInsets.fromLTRB(20, 5, 15, 5),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 10,
          child: SizedBox(
            height: 400,
            child: Column(
              children: <Widget>[
                Row(children: [
                  const Padding(padding: EdgeInsets.all(8)),
                  Image.network(
                    item.image.toString(),
                    fit: BoxFit.fill,
                    height: 25,
                    width: 25,
                  ),
                ]),
                Row(children: [
                  const Padding(padding: EdgeInsets.all(8)),
                  Text(
                    item.name,
                    style: const TextStyle(fontSize: 13),
                  )
                ]),
                Row(children: [
                  const Padding(padding: EdgeInsets.all(8)),
                  Text(
                    "Quantity: " + item.quantity.toString(),
                    style: const TextStyle(fontSize: 11),
                  )
                ]),
                //    onTap: () {
                //      Navigator.push(context, MaterialPageRoute(builder: (_) {
                //        return DetailScreen(item);
                //       }));
                //     },
                //   ),
              ],
            ),
          )),
    );
  }
}

