import 'package:hive/hive.dart';

part 'apartment_hive_model.g.dart';

@HiveType(typeId: 0)
class ApartmentHiveModel extends HiveObject {
  @HiveField(0)
  String apartmentId;

  @HiveField(1)
  String apartmentStatus;

  @HiveField(2)
  String vacantFrom;

  @HiveField(3)
  String gender;

  @HiveField(4)
  String address;

  @HiveField(5)
  double rooms;  // Changed from String to double

  @HiveField(6)
  double sizeM2;  // Changed from String to double

  @HiveField(7)
  double rent;  // Changed from String to double

  @HiveField(8)
  String floor;

  @HiveField(9)
  bool placeForWashingMachine;

  @HiveField(10)
  bool placeForDishwasher;

  @HiveField(11)
  String floorMaterial;

  @HiveField(12)
  String bedroomWindow;

  @HiveField(13)
  String livingRoomWindow;

  @HiveField(14)
  String balcony;

  @HiveField(15)
  String sauna;

  @HiveField(16)
  String stove;

  @HiveField(17)
  String fixedLampInRoom;

  @HiveField(18)
  String information;

  @HiveField(19)
  String reserveButton;

  @HiveField(20)
  String asun;

  @HiveField(21)
  String parentLocation;

  @HiveField(22)
  String apartmentType;

  @HiveField(23)
  List<String> imageList;

  @HiveField(24)
  String ownUrl;

  @HiveField(25)
  String updatedAt;

  ApartmentHiveModel({
    required this.apartmentId,
    required this.apartmentStatus,
    required this.vacantFrom,
    required this.gender,
    required this.address,
    required this.rooms,
    required this.sizeM2,
    required this.rent,
    required this.floor,
    required this.placeForWashingMachine,
    required this.placeForDishwasher,
    required this.floorMaterial,
    required this.bedroomWindow,
    required this.livingRoomWindow,
    required this.balcony,
    required this.sauna,
    required this.stove,
    required this.fixedLampInRoom,
    required this.information,
    required this.reserveButton,
    required this.asun,
    required this.parentLocation,
    required this.apartmentType,
    required this.imageList,
    required this.ownUrl,
    required this.updatedAt,
  });
}