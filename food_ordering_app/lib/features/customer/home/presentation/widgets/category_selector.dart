import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'Eat what makes you happy',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RoundCategoryItem(
              imagePath: 'assets/images/appetizer.jpg',
              label: 'Appetizers',
              onTap: () {},
            ),
            RoundCategoryItem(
              imagePath: 'assets/images/starters.jpg',
              label: 'Starters',
              onTap: () {},
            ),
            RoundCategoryItem(
              imagePath: 'assets/images/main_course.jpg',
              label: 'Main Course',
              onTap: () {},
            ),
            RoundCategoryItem(
              imagePath: 'assets/images/dessert.jpg',
              label: 'Desserts',
              onTap: () {},
            )
          ],
        )
      ],
    );
  }
}

class RoundCategoryItem extends StatelessWidget {
  final String imagePath;
  final String label;
  final onTap;

  const RoundCategoryItem(
      {Key? key,
      required this.imagePath,
      required this.label,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(imagePath),
            radius: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: Text(label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
