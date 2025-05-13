// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apartment_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ApartmentHiveModelAdapter extends TypeAdapter<ApartmentHiveModel> {
  @override
  final int typeId = 0;

  @override
  ApartmentHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ApartmentHiveModel(
      apartmentId: fields[0] as String,
      apartmentStatus: fields[1] as String,
      vacantFrom: fields[2] as String,
      gender: fields[3] as String,
      address: fields[4] as String,
      rooms: fields[5] as double,
      sizeM2: fields[6] as double,
      rent: fields[7] as double,
      floor: fields[8] as String,
      placeForWashingMachine: fields[9] as bool,
      placeForDishwasher: fields[10] as bool,
      floorMaterial: fields[11] as String,
      bedroomWindow: fields[12] as String,
      livingRoomWindow: fields[13] as String,
      balcony: fields[14] as String,
      sauna: fields[15] as String,
      stove: fields[16] as String,
      fixedLampInRoom: fields[17] as String,
      information: fields[18] as String,
      reserveButton: fields[19] as String,
      asun: fields[20] as String,
      parentLocation: fields[21] as String,
      apartmentType: fields[22] as String,
      imageList: (fields[23] as List).cast<String>(),
      ownUrl: fields[24] as String,
      updatedAt: fields[25] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ApartmentHiveModel obj) {
    writer
      ..writeByte(26)
      ..writeByte(0)
      ..write(obj.apartmentId)
      ..writeByte(1)
      ..write(obj.apartmentStatus)
      ..writeByte(2)
      ..write(obj.vacantFrom)
      ..writeByte(3)
      ..write(obj.gender)
      ..writeByte(4)
      ..write(obj.address)
      ..writeByte(5)
      ..write(obj.rooms)
      ..writeByte(6)
      ..write(obj.sizeM2)
      ..writeByte(7)
      ..write(obj.rent)
      ..writeByte(8)
      ..write(obj.floor)
      ..writeByte(9)
      ..write(obj.placeForWashingMachine)
      ..writeByte(10)
      ..write(obj.placeForDishwasher)
      ..writeByte(11)
      ..write(obj.floorMaterial)
      ..writeByte(12)
      ..write(obj.bedroomWindow)
      ..writeByte(13)
      ..write(obj.livingRoomWindow)
      ..writeByte(14)
      ..write(obj.balcony)
      ..writeByte(15)
      ..write(obj.sauna)
      ..writeByte(16)
      ..write(obj.stove)
      ..writeByte(17)
      ..write(obj.fixedLampInRoom)
      ..writeByte(18)
      ..write(obj.information)
      ..writeByte(19)
      ..write(obj.reserveButton)
      ..writeByte(20)
      ..write(obj.asun)
      ..writeByte(21)
      ..write(obj.parentLocation)
      ..writeByte(22)
      ..write(obj.apartmentType)
      ..writeByte(23)
      ..write(obj.imageList)
      ..writeByte(24)
      ..write(obj.ownUrl)
      ..writeByte(25)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApartmentHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
