// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BudgetDataAdapter extends TypeAdapter<BudgetData> {
  @override
  final int typeId = 2;

  @override
  BudgetData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BudgetData(
      fields[0] as String,
      fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, BudgetData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.category)
      ..writeByte(1)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BudgetDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
