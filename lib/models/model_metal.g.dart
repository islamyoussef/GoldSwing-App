// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_metal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelMetalAdapter extends TypeAdapter<ModelMetal> {
  @override
  final int typeId = 0;

  @override
  ModelMetal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelMetal(
      timestamp: fields[0] as int,
      metal: fields[1] as String,
      currency: fields[2] as String,
      exchange: fields[3] as String,
      symbol: fields[4] as String,
      openTime: fields[5] as int,
      price: fields[6] as double,
      ch: fields[7] as double,
      ask: fields[8] as double,
      bid: fields[9] as double,
      priceGram24K: fields[10] as double,
      priceGram22K: fields[11] as double,
      priceGram21K: fields[12] as double,
      priceGram20K: fields[13] as double,
      priceGram18K: fields[14] as double,
      priceGram16K: fields[15] as double,
      priceGram14K: fields[16] as double,
      priceGram10K: fields[17] as double,
      recordID: fields[18] as int,
      responseMsg: fields[19] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ModelMetal obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.timestamp)
      ..writeByte(1)
      ..write(obj.metal)
      ..writeByte(2)
      ..write(obj.currency)
      ..writeByte(3)
      ..write(obj.exchange)
      ..writeByte(4)
      ..write(obj.symbol)
      ..writeByte(5)
      ..write(obj.openTime)
      ..writeByte(6)
      ..write(obj.price)
      ..writeByte(7)
      ..write(obj.ch)
      ..writeByte(8)
      ..write(obj.ask)
      ..writeByte(9)
      ..write(obj.bid)
      ..writeByte(10)
      ..write(obj.priceGram24K)
      ..writeByte(11)
      ..write(obj.priceGram22K)
      ..writeByte(12)
      ..write(obj.priceGram21K)
      ..writeByte(13)
      ..write(obj.priceGram20K)
      ..writeByte(14)
      ..write(obj.priceGram18K)
      ..writeByte(15)
      ..write(obj.priceGram16K)
      ..writeByte(16)
      ..write(obj.priceGram14K)
      ..writeByte(17)
      ..write(obj.priceGram10K)
      ..writeByte(18)
      ..write(obj.recordID)
      ..writeByte(19)
      ..write(obj.responseMsg);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelMetalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
