import 'package:younes_mobile/models/item.dart';

class ItemsService {
  static Future<List<Item>> getItems() async {
    return [
      Item(
        id: '1',
        name: 'Item 1',
        price: 1.99,
        quantity: 1,
        image: 'https://picsum.photos/200/300/?random',
      ),
      Item(
        id: '2',
        name: 'Item 2',
        price: 2.99,
        quantity: 2,
        image: 'https://picsum.photos/200/300/?random',
      ),
      Item(
        id: '3',
        name: 'Item 3',
        price: 3.99,
        quantity: 3,
        image: 'https://picsum.photos/200/300/?random',
      ),
      Item(
        id: '4',
        name: 'Item 4',
        price: 4.99,
        quantity: 4,
        image: 'https://picsum.photos/200/300/?random',
      ),
      Item(
        id: '5',
        name: 'Item 5',
        price: 5.99,
        quantity: 5,
        image: 'https://picsum.photos/200/300/?random',
      ),
      Item(
        id: '6',
        name: 'Item 6',
        price: 6.99,
        quantity: 6,
        image: 'https://picsum.photos/200/300/?random',
      ),
      Item(
        id: '7',
        name: 'Item 7',
        price: 7.99,
        quantity: 7,
        image: 'https://picsum.photos/200/300/?random',
      ),
      Item(
        id: '8',
        name: 'Item 8',
        price: 8.99,
        quantity: 8,
        image: 'https://picsum.photos/200/300/?random',
      ),
      Item(
        id: '9',
        name: 'Item 9',
        price: 9.99,
        quantity: 9,
        image: 'https://picsum.photos/200/300/?random',
      ),
    ];
  }
}
