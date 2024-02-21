// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barang.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BarangHiveAdapter extends TypeAdapter<BarangHive> {
  @override
  final int typeId = 0;

  @override
  BarangHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BarangHive(
      name: fields[0] as String,
      price: fields[1] as int,
      stock: fields[2] as int,
      expiredAt: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BarangHive obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.stock)
      ..writeByte(3)
      ..write(obj.expiredAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarangHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
