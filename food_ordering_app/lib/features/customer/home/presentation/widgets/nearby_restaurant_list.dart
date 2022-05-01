import 'package:flutter/material.dart';
import 'package:food_ordering_app/features/customer/home/presentation/widgets/restaurant_card.dart';

class NearbyRestaurantList extends StatelessWidget {
  const NearbyRestaurantList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Restaurants around you ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              letterSpacing: 1.5,
            ),
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return RestaurantCard();
              }),
        ],
      ),
    );
  }
}
