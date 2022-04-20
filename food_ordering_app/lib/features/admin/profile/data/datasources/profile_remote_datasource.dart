import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:food_ordering_app/core/error/exceptions.dart';
import 'package:food_ordering_app/features/admin/menu/data/models/menuitem_model.dart';
import 'package:food_ordering_app/features/admin/profile/data/models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<RestaurantProfileModel> loadProfile(String restaurantId);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  @override
  Future<RestaurantProfileModel> loadProfile(String restaurantId) async {
    late RestaurantProfileModel profileModel;
    try {
      await FirebaseFirestore.instance
          .collection("restaurants")
          .doc(restaurantId)
          .get()
          .then((value) {
        profileModel = RestaurantProfileModel.fromJson(value.data()!);
        print(profileModel);
      });
      return profileModel;
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
