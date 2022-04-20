import 'package:equatable/equatable.dart';

class RestaurantProfile extends Equatable {
  final String restaurantId;
  final String restaurantName;
  final String address;
  final String phone;
  final String email;
  final double rating;
  RestaurantProfile({
    required this.restaurantId,
    required this.restaurantName,
    required this.address,
    required this.phone,
    required this.email,
    required this.rating,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        restaurantId,
        restaurantName,
        address,
        phone,
        email,
        rating,
      ];
}
