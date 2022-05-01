import 'package:food_ordering_app/features/admin/profile/domain/entities/profile.dart';

class RestaurantProfileModel extends RestaurantProfile {
  RestaurantProfileModel(
      {required String restaurantId,
      required String restaurantName,
      required String address,
      required String phone,
      required String email,
      required double rating,
      required int nratings})
      : super(
            address: address,
            email: email,
            phone: phone,
            rating: rating,
            nratings: nratings,
            restaurantId: restaurantId,
            restaurantName: restaurantName);
  factory RestaurantProfileModel.fromJson(Map<String, dynamic> json) {
    return RestaurantProfileModel(
        restaurantId: json['restaurantId'],
        restaurantName: json['restaurantName'],
        address: json['address'],
        phone: json['phone'].toString(),
        email: json['email'],
        rating: json['rating'].toDouble(),
        nratings: json['nratings']);
  }

  Map<String, dynamic> toJson() {
    return {
      'restaurantId': restaurantId,
      'restaurantName': restaurantName,
      'address': address,
      'phone': phone,
      'email': email,
      'rating': rating,
      'nratings': nratings
    };
  }
}
