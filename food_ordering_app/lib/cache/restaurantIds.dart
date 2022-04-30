import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer' as d;

import 'package:food_ordering_app/cache/ids.dart';
import 'package:hive/hive.dart';

bool cacheRestaurantIds() {
  var box = Hive.box<Id>('restaurantIds');
  box.clear();

  FirebaseFirestore.instance.collection("restaurants").get().then((value) {
    value.docs.forEach((element) {
      FirebaseFirestore.instance
          .collection("restaurants")
          .doc(element.id)
          .get()
          .then((value) {
        box.put(
            element.id,
            Id(
                id: element.id,
                name: value.data()!["restaurantName"],
                rating: value.data()!["rating"].toString()));
      });
    });
  });
  return true;
}

List<String> getRestaurantIds() {
  Box box = Hive.box<Id>('restaurantIds');
  List<String> ids = [];
  box.values.forEach((element) {
    ids.add(element.id);
  });
  return ids;
}
