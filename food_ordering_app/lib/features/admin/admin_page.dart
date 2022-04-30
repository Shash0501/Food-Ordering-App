import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/features/admin/menu/presentation/pages/menu_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'order/presentation/pages/order_page.dart';
import 'profile/presentation/pages/profilepage.dart';

class MyAdminPage extends StatefulWidget {
  String restaurantId;
  MyAdminPage({Key? key, required this.restaurantId}) : super(key: key);

  @override
  State<MyAdminPage> createState() => _MyAdminPageState();
}

class _MyAdminPageState extends State<MyAdminPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: const Text("ADMIN"),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                final googleSignIn = GoogleSignIn();
                await googleSignIn.disconnect();
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
          bottom: TabBar(tabs: [
            Tab(
              child: Text("Menu"),
            ),
            Tab(
              child: Text("Profile"),
            ),
            Tab(
              child: Text("Orders"),
            )
          ]),
        ),
        body: TabBarView(
          children: [
            OrderPage(restaurantId: widget.restaurantId),
            ProfilePage(restaurantId: widget.restaurantId),
            MenuPage(restaurantId: widget.restaurantId),
          ],
        ),
      ),
    );
  }
}
