import 'package:food_ordering_app/features/customer/home/data/models/menuitem_model.dart';
import 'package:hive/hive.dart';
part 'order.g.dart';

@HiveType(typeId: 1)
class CurrentOrder {
  @HiveField(0)
  final Map<String, dynamic> order;
  @HiveField(1)
  final String itemId;
  @HiveField(2)
  final int quantity;
  @HiveField(3)
  final String itemName;
  @HiveField(4)
  final String category;
  @HiveField(5)
  final int price;
  @HiveField(6)
  final bool isVeg;
  @HiveField(7)
  final bool isAvailable;
  @HiveField(8)
  final String description;
  @HiveField(9)
  final String restaurantId;

  CurrentOrder(
      {required this.order,
      required this.itemId,
      required this.quantity,
      required this.category,
      required this.price,
      required this.isVeg,
      required this.isAvailable,
      required this.description,
      required this.restaurantId,
      required this.itemName});
}
