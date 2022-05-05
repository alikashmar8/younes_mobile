import 'package:younes_mobile/models/folder.dart';

class FoldersService {
  static Future<List<Folder>> getFolders() async {
    return [
      Folder(
        id: '1',
        name: 'Folder 1',
        price: 1.99,
        quantity: 1,
        parentId: '0',
      ),
      Folder(
        id: '2',
        name: 'Folder 2',
        price: 2.99,
        quantity: 2,
        parentId: '0',
      ),
      Folder(
        id: '3',
        name: 'Folder 3',
        price: 3.99,
        quantity: 3,
        parentId: '0',
      ),
      Folder(
        id: '4',
        name: 'Folder 4',
        price: 4.99,
        quantity: 4,
        parentId: '0',
      ),
      Folder(
        id: '5',
        name: 'Folder 5',
        price: 5.99,
        quantity: 5,
        parentId: '0',
      ),
      Folder(
        id: '6',
        name: 'Folder 6',
        price: 6.99,
        quantity: 6,
        parentId: '0',
      ),
      Folder(
        id: '7',
        name: 'Folder 7',
        price: 7.99,
        quantity: 7,
        parentId: '0',
      ),
      Folder(
        id: '8',
        name: 'Folder 8',
        price: 8.99,
        quantity: 8,
        parentId: '0',
      )
    ];
  }
}
