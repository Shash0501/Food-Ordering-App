import 'package:food_ordering_app/features/admin/profile/domain/entities/profile.dart';

class RestaurantProfileModel extends RestaurantProfile {
  RestaurantProfileModel(
      {required String restaurantId,
      required String restaurantName,
      required String address,
      required String phone,
      required String email,
      required double rating})
      : super(
            address: address,
            email: email,
            phone: phone,
            rating: rating,
            restaurantId: restaurantId,
            restaurantName: restaurantName);

  factory RestaurantProfileModel.fromJson(Map<String, dynamic> json) {
    return RestaurantProfileModel(
        restaurantId: json['restaurantId'],
        restaurantName: json['restaurantName'],
        address: json['address'],
        phone: json['phone'],
        email: json['email'],
        rating: json['rating']);
  }

  Map<String, dynamic> toJson() {
    return {
      'restaurantId': restaurantId,
      'restaurantName': restaurantName,
      'address': address,
      'phone': phone,
      'email': email,
      'rating': rating
    };
  }
}
