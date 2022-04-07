import 'package:flutter/material.dart';
import 'package:food_ordering_app/features/admin/menu/presentation/pages/menu_page.dart';

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
          title: const Text("ADMIN"),
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
            MenuPage(restaurantId: widget.restaurantId),
            Icon(Icons.flight, size: 350),
            Icon(Icons.directions_car, size: 350),
          ],
        ),
      ),
    );
  }
}
