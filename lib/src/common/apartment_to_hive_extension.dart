// Add these methods to your ApartmentHiveModel class
import '../features/apartments/data/models/apartment_hive_model.dart';
import '../features/apartments/data/models/apartment_model.dart';

extension ApartmentModelConverter on ApartmentModel {
  // Convert from ApartmentModel to ApartmentHiveModel
  ApartmentHiveModel toHiveModel() {
    return ApartmentHiveModel(
      apartmentId: apartmentId, // Assuming ApartmentModel has an id field
      apartmentStatus: apartmentStatus, // Fill with appropriate data
      vacantFrom: vacantFrom, // Fill with appropriate data
      gender: gender, // Fill with appropriate data
      address: address,
      rooms: rooms, // Fill with appropriate data
      sizeM2: sizeM2, // Fill with appropriate data
      rent: rent,
      floor: floor, // Fill with appropriate data
      placeForWashingMachine: placeForWashingMachine, // Fill with appropriate data
      placeForDishwasher: placeForDishwasher, // Fill with appropriate data
      floorMaterial: floorMaterial, // Fill with appropriate data
      bedroomWindow: bedroomWindow, // Fill with appropriate data
      livingRoomWindow: livingRoomWindow, // Fill with appropriate data
      balcony: balcony, // Fill with appropriate data
      sauna: sauna, // Fill with appropriate data
      stove: stove, // Fill with appropriate data
      fixedLampInRoom: fixedLampInRoom, // Fill with appropriate data
      information: information, // Fill with appropriate data
      reserveButton: reserveButton.toString(),
      asun: asun, // Fill with appropriate data
      parentLocation: parentLocation,
      apartmentType: apartmentType, // Fill with appropriate data
      imageList: imageList,
      ownUrl: ownUrl, // Fill with appropriate data
      updatedAt: DateTime.now().toIso8601String(),
    );
  }
}

extension HiveModelConverter on ApartmentHiveModel {
  // Convert from ApartmentHiveModel to ApartmentModel
  ApartmentModel toApartmentModel() {
    return ApartmentModel(
      apartmentId: apartmentId,
      address: address,
      parentLocation: parentLocation,
      rent: rent,
      imageList: imageList,
      reserveButton: reserveButton,
      updatedAt: updatedAt,
      ownUrl: ownUrl,
      information: information,
      apartmentStatus: apartmentStatus,
      vacantFrom: vacantFrom,
      apartmentType: apartmentType,
      asun: asun,
      balcony: balcony,
      bedroomWindow: bedroomWindow,
      fixedLampInRoom: fixedLampInRoom,
      floor: floor,
      floorMaterial: floorMaterial,
      sauna: sauna,
      stove: stove,
      livingRoomWindow: livingRoomWindow,
      placeForDishwasher: placeForDishwasher,
      placeForWashingMachine: placeForWashingMachine,
      rooms: rooms,
      sizeM2: sizeM2,
      


      // Add other fields from ApartmentModel if needed
    );
  }
}