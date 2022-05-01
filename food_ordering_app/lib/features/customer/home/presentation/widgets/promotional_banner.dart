import 'package:flutter/material.dart';

class PromotionalBanner extends StatelessWidget {
  const PromotionalBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(
        padding: EdgeInsets.all(15.0),
        child: Text(
          'Check These Out',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10), // Image border
            child: SizedBox(
              height: 100,
              child:
                  Image.asset('assets/images/banner1.jpg', fit: BoxFit.cover),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10), // Image border
            child: SizedBox(
              height: 100,
              child:
                  Image.asset('assets/images/banner2.jpg', fit: BoxFit.cover),
            ),
          )
        ],
      )
    ]);
  }
}
