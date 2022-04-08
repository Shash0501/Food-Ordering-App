import 'package:flutter/material.dart';
import 'package:food_ordering_app/core/config/constants.dart';

class CategoryList extends StatelessWidget {
  final int selected;
  final Function(int) callback;
  CategoryList({required this.selected, required this.callback});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: MediaQuery.of(context).size.width * 0.98,
      child: Expanded(
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: categories.length,
            itemBuilder: (coontext, index) {
              return GestureDetector(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: selected != index
                            ? Colors.yellowAccent
                            : Colors.amber[700]),
                    child: Text(
                      categories[index],
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: selected != index
                              ? FontWeight.normal
                              : FontWeight.bold),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
