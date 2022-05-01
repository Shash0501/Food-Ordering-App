import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  final onTap;
  const RestaurantCard({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
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
                          'Red Rock Agency',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              letterSpacing: 1.5,
                              color: Colors.black),
                        ),
                      ),
                      Text('3.1 Stars')
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text('Pizza, Burger, Momos'),
                      ),
                      Text('Rs. 150 for one'),
                    ],
                  ),
                  Divider(
                    height: 10,
                    color: Colors.grey,
                  ),
                  Text('We recycle more plastic than used in our orders'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
