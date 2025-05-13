import '../features/apartments/data/models/apartment_hive_model.dart';
import '../features/apartments/data/models/apartment_model.dart';

extension ApartmentToHiveExtension on ApartmentModel {
  ApartmentHiveModel toHiveModel() {
    return ApartmentHiveModel(
      apartmentId: apartmentId,
      apartmentStatus: apartmentStatus,
      vacantFrom: vacantFrom,
      gender: gender,
      address: address,
      rooms: rooms,  // Now passing double directly
      sizeM2: sizeM2,  // Now passing double directly
      rent: rent,  // Now passing double directly
      floor: floor,
      placeForWashingMachine: placeForWashingMachine,
      placeForDishwasher: placeForDishwasher,
      floorMaterial: floorMaterial,
      bedroomWindow: bedroomWindow,
      livingRoomWindow: livingRoomWindow,
      balcony: balcony,
      sauna: sauna,
      stove: stove,
      fixedLampInRoom: fixedLampInRoom,
      information: information,
      reserveButton: reserveButton,
      asun: asun,
      parentLocation: parentLocation,
      apartmentType: apartmentType,
      imageList: imageList,
      ownUrl: ownUrl,
      updatedAt: updatedAt,
    );
  }
}

extension HiveToApartmentExtension on ApartmentHiveModel {
  ApartmentModel toApartmentModel() {
    return ApartmentModel(
      apartmentId: apartmentId,
      apartmentStatus: apartmentStatus,
      vacantFrom: vacantFrom,
      gender: gender,
      address: address,
      rooms: rooms,  // Now passing double directly
      sizeM2: sizeM2,  // Now passing double directly
      rent: rent,  // Now passing double directly
      floor: floor,
      placeForWashingMachine: placeForWashingMachine,
      placeForDishwasher: placeForDishwasher,
      floorMaterial: floorMaterial,
      bedroomWindow: bedroomWindow,
      livingRoomWindow: livingRoomWindow,
      balcony: balcony,
      sauna: sauna,
      stove: stove,
      fixedLampInRoom: fixedLampInRoom,
      information: information,
      reserveButton: reserveButton,
      asun: asun,
      parentLocation: parentLocation,
      apartmentType: apartmentType,
      imageList: imageList,
      ownUrl: ownUrl,
      updatedAt: updatedAt,
    );
  }
}