import 'package:flutter/material.dart';
import 'package:food_ordering_app/features/admin/profile/domain/entities/profile.dart';

import '../../../../admin/profile/data/models/profile_model.dart';

class RestaurantCard extends StatelessWidget {
  RestaurantProfileModel restaurantProfile;
  RestaurantCard({Key? key, required this.restaurantProfile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(0),
          title: Image.asset(
            'assets/images/profile.jpg',
          ),
          subtitle: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        restaurantProfile.restaurantName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            letterSpacing: 1.5,
                            color: Colors.black),
                      ),
                    ),
                    Text(restaurantProfile.rating.toString()),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(restaurantProfile.email),
                    ),
                    Text('${restaurantProfile.nratings} ratings'),
                  ],
                ),
                Text(restaurantProfile.address),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
