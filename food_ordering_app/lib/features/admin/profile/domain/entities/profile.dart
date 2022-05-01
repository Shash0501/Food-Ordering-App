import 'package:equatable/equatable.dart';

class RestaurantProfile extends Equatable {
  final String restaurantId;
  final String restaurantName;
  final String address;
  final String phone;
  final String email;
  final double rating;
  final int nratings;
  RestaurantProfile({
    required this.restaurantId,
    required this.restaurantName,
    required this.address,
    required this.phone,
    required this.email,
    required this.rating,
    required this.nratings,
  });

  @override
  // TODO: implement props
  List<Object?> get props =>
      [restaurantId, restaurantName, address, phone, email, rating, nratings];
}
