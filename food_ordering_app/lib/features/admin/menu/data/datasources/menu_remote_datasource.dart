import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MenuRemoteDataSource {
  Future<bool> addItem(
    String restaurantId,
    String itemName,
    String category,
    int price,
    bool isVeg,
    bool isAvailable,
  );
}

class MenuRemoteDataSourceImpl implements MenuRemoteDataSource {
  @override
  Future<bool> addItem(String restaurantId, String itemName, String category,
      int price, bool isVeg, bool isAvailable) async {
    dynamic itemJson = {
      'itemName': itemName,
      'price': price,
      'isVeg': isVeg,
      'isAvailable': isAvailable,
    };
    String isveg = isVeg ? 'Vegetarian' : 'Non-Vegetarian';
    await FirebaseFirestore.instance
        .collection("restaurants")
        .doc(restaurantId)
        .collection("menu")
        .doc(isveg)
        .collection(category)
        .doc()
        .set(itemJson);
    print("Item added");
    return true;
  }
}
