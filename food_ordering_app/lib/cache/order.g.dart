// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrentOrderAdapter extends TypeAdapter<CurrentOrder> {
  @override
  final int typeId = 1;

  @override
  CurrentOrder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrentOrder(
      order: (fields[0] as Map).cast<String, dynamic>(),
      itemId: fields[1] as String,
      quantity: fields[2] as int,
      category: fields[4] as String,
      price: fields[5] as int,
      isVeg: fields[6] as bool,
      isAvailable: fields[7] as bool,
      description: fields[8] as String,
      restaurantId: fields[9] as String,
      itemName: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CurrentOrder obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.order)
      ..writeByte(1)
      ..write(obj.itemId)
      ..writeByte(2)
      ..write(obj.quantity)
      ..writeByte(3)
      ..write(obj.itemName)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.isVeg)
      ..writeByte(7)
      ..write(obj.isAvailable)
      ..writeByte(8)
      ..write(obj.description)
      ..writeByte(9)
      ..write(obj.restaurantId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrentOrderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
