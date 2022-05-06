import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/features/customer/home/presentation/pages/profile_page_c.dart';
import 'package:food_ordering_app/features/customer/home/presentation/widgets/nearby_restaurant_list.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';

import '../../../../../cache/ids.dart';
import '../bloc/homepage_bloc.dart';
import '../widgets/category_selector.dart';
import '../widgets/counter.dart';
import '../widgets/promotional_banner.dart';
import 'cart_page.dart';
import 'order_history_page.dart';

class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({Key? key}) : super(key: key);

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  @override
  void initState() {
    var box = Hive.box<Id>("restaurantIds");
    BlocProvider.of<HomepageBloc>(context).add(CacheRestaurantIds());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              heroTag: 1,
              child: Icon(Icons.history),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OrderHistoryPage(
                        userId: FirebaseAuth.instance.currentUser!.email
                            .toString())));
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: ListTile(
                      title: Text(
                        'Dodda Kopla',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text('Surathkal, Mangaluru'),
                      leading: CircleAvatar(
                        child: Icon(Icons.location_pin, color: Colors.red),
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProfilePageC()));
                    },
                    icon: const CircleAvatar(
                      child: Icon(Icons.account_circle),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.red,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final googleSignIn = GoogleSignIn();
                      await googleSignIn.disconnect();
                      FirebaseAuth.instance.signOut();
                    },
                    icon: const CircleAvatar(
                      child: Icon(Icons.logout),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.red,
                    ),
                  ),
                ],
              ),
              const PromotionalBanner(),
              const CategorySelector(),
              NearbyRestaurantList(),
            ],
          ),
        ),
      ),
    ));
  }
}
