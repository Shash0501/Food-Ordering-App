import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/features/customer/home/presentation/pages/create_order_page.dart';
import 'package:food_ordering_app/features/admin/profile/data/models/profile_model.dart';
import 'package:food_ordering_app/features/customer/home/presentation/widgets/restaurant_card.dart';

class NearbyRestaurantList extends StatefulWidget {
  NearbyRestaurantList({Key? key}) : super(key: key);

  @override
  State<NearbyRestaurantList> createState() => _NearbyRestaurantListState();
}

class _NearbyRestaurantListState extends State<NearbyRestaurantList> {
  Future<List<RestaurantProfileModel>> getRestaurants() async {
    List<RestaurantProfileModel> restaurants = [];
    await FirebaseFirestore.instance
        .collection("restaurants")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        restaurants.add(RestaurantProfileModel.fromJson(element.data()));
      });
    });
    return restaurants;
  }

  @override
  void initState() {
    super.initState();
  }

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
          FutureBuilder<dynamic>(
              future: getRestaurants(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return RestaurantCard(
                          restaurantProfile: snapshot.data[index],
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CreateOrderPage(
                                    restaurantProfile: snapshot.data[index])));
                          },
                        );
                      });
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Container();
                } else {
                  return Center(
                    child: Text('No Restaurants Found'),
                  );
                }
              }),
        ],
      ),
    );
  }
}
