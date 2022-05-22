// ignore_for_file: file_names, non_constant_identifier_names

import 'package:younes_mobile/common/api-endpoints.dart';
import 'package:younes_mobile/common/api.service.dart';
import 'package:younes_mobile/models/gallery-item.dart';

class GalleryItemsService {
  final ApiService apiService = ApiService();

  // static Future<List<GalleryItem>> getGalleryItems() async {
  //   return [
  //     GalleryItem(
  //       id: '1',
  //       name: 'GalleryItem 1',
  //       price: 1.99,
  //       quantity: 1,
  //       image: 'https://picsum.photos/100/100/?random',
  //       parentId: '0',
  //       type: 'folder',
  //       description: 'This is a description',
  //       isActive: true,
  //       businessId: '1',
  //       createdById: '1',
  //       updatedById: '1',
  //     ),
  //     GalleryItem(
  //       id: '2',
  //       name: 'GalleryItem 2',
  //       price: 2.99,
  //       quantity: 2,
  //       image: 'https://picsum.photos/100/100/?random',
  //       parentId: '0',
  //       type: 'folder',
  //       description: 'This is a description',
  //       isActive: true,
  //       businessId: '1',
  //       createdById: '1',
  //       updatedById: '1',
  //     ),
  //     GalleryItem(
  //       id: '3',
  //       name: 'GalleryItem 3',
  //       price: 3.99,
  //       quantity: 3,
  //       image: 'https://picsum.photos/100/100/?random',
  //       parentId: '0',
  //       type: 'folder',
  //       description: 'This is a description',
  //       isActive: true,
  //       businessId: '1',
  //       createdById: '1',
  //       updatedById: '1',
  //     ),
  //     GalleryItem(
  //       id: '4',
  //       name: 'GalleryItem 4',
  //       price: 4.99,
  //       quantity: 4,
  //       image: 'https://picsum.photos/100/100/?random',
  //       parentId: '0',
  //       type: 'folder',
  //       description: 'This is a description',
  //       isActive: true,
  //       businessId: '1',
  //       createdById: '1',
  //       updatedById: '1',
  //     ),
  //     GalleryItem(
  //       id: '5',
  //       name: 'GalleryItem 5',
  //       price: 5.99,
  //       quantity: 5,
  //       image: 'https://picsum.photos/100/100/?random',
  //       parentId: '0',
  //       type: 'file',
  //       description: 'This is a description',
  //       isActive: true,
  //       businessId: '1',
  //       createdById: '1',
  //       updatedById: '1',
  //     ),
  //     GalleryItem(
  //       id: '6',
  //       name: 'GalleryItem 6',
  //       price: 6.99,
  //       quantity: 6,
  //       image: 'https://picsum.photos/100/100/?random',
  //       parentId: '0',
  //       type: 'file',
  //       description: 'This is a description',
  //       isActive: true,
  //       businessId: '1',
  //       createdById: '1',
  //       updatedById: '1',
  //     ),
  //     GalleryItem(
  //       id: '7',
  //       name: 'GalleryItem 7',
  //       price: 7.99,
  //       quantity: 7,
  //       image: 'https://picsum.photos/100/100/?random',
  //       parentId: '0',
  //       type: 'file',
  //       description: 'This is a description',
  //       isActive: true,
  //       businessId: '1',
  //       createdById: '1',
  //       updatedById: '1',
  //     ),
  //     GalleryItem(
  //       id: '8',
  //       name: 'GalleryItem 8',
  //       price: 8.99,
  //       quantity: 8,
  //       image: 'https://picsum.photos/100/100/?random',
  //       parentId: '0',
  //       type: 'file',
  //       description: 'This is a description',
  //       isActive: true,
  //       businessId: '1',
  //       createdById: '1',
  //       updatedById: '1',
  //     ),
  //     GalleryItem(
  //       id: '9',
  //       name: 'GalleryItem 9',
  //       price: 9.99,
  //       quantity: 9,
  //       image: 'https://picsum.photos/100/100/?random',
  //       parentId: '0',
  //       type: 'file',
  //       description: 'This is a description',
  //       isActive: true,
  //       businessId: '1',
  //       createdById: '1',
  //       updatedById: '1',
  //     ),
  //   ];
  // }

  Future<List<GalleryItem>> getGalleryItems(String? parent_id) async {
    String queryParams = parent_id != null ? '?parent_id=$parent_id' : '';
    List<dynamic> list =
        await apiService.getResponse(galleryItemsEndpoint + '' + queryParams);
    return list.map((e) => GalleryItem.fromJson(e)).toList();
  }
}
