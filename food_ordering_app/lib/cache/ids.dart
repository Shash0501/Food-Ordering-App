import 'package:hive/hive.dart';

part 'ids.g.dart';

@HiveType(typeId: 0)
class Id {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String rating;
  Id({required this.id, required this.name, required this.rating});
}
