import 'package:get/get.dart';
import 'package:younes_mobile/services/gallery-items.service.dart';

class GalleryItemsController extends GetxController {
  var isLoading = true.obs;
  var itemsList = [].obs;
  

  @override
  void onInit() {
    fetchItems();
    super.onInit();
  }

  void fetchItems() async {
    try {
      isLoading(true);
      var items = await GalleryItemsService.getGalleryItems();
      if (items != null) {
        itemsList.value = items;
      }
    } finally {
      isLoading(false);
    }
  }
}