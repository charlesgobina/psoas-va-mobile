// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ApartmentModel {
  String apartmentId;
  String apartmentStatus;
  String vacantFrom;
  String gender;
  String address;
  double rooms;         // Changed from String to double
  double sizeM2;        // Changed from String to double
  double rent;          // Changed from String to double
  String floor;
  bool placeForWashingMachine;
  bool placeForDishwasher;
  String floorMaterial;
  String bedroomWindow;
  String livingRoomWindow;
  String balcony;
  String sauna;
  String stove;
  var fixedLampInRoom = '';
  String information;
  String reserveButton;
  String asun;
  String parentLocation;
  String apartmentType;
  List<String> imageList;
  String ownUrl;
  String updatedAt;

  ApartmentModel({
    String? updatedAt,
    this.apartmentId = "",
    this.apartmentStatus = "",
    this.vacantFrom = "",
    this.gender = "",
    this.address = "",
    this.rooms = 0.0,      // Default changed to 0.0
    this.sizeM2 = 0.0,     // Default changed to 0.0
    this.rent = 0.0,       // Default changed to 0.0
    this.floor = "",
    this.placeForWashingMachine = false,
    this.placeForDishwasher = false,
    this.floorMaterial = "",
    this.bedroomWindow = "",
    this.livingRoomWindow = "",
    this.balcony = "",
    this.sauna = "",
    this.stove = "",
    this.fixedLampInRoom = "",
    this.information = "",
    this.reserveButton = "",
    this.asun = "",
    this.parentLocation = "",
    this.apartmentType = "",
    this.imageList = const [],
    this.ownUrl = "",
  }) : 
        updatedAt = updatedAt ?? DateTime.now().toIso8601String();

  factory ApartmentModel.fromJson(Map<String, dynamic> json) {
    return ApartmentModel(
      apartmentId: json['apartmentId'],
      apartmentStatus: json['apartmentStatus'],
      vacantFrom: json['vacantFrom'],
      gender: json['gender'],
      address: json['address'],
      rooms: _parseDouble(json['rooms']),
      sizeM2: _parseDouble(json['sizeM2']),
      rent: _parseDouble(json['rent']),
      floor: json['floor'],
      placeForWashingMachine: json['placeForWashingMachine'],
      placeForDishwasher: json['placeForDishwasher'],
      floorMaterial: json['floorMaterial'],
      bedroomWindow: json['bedroomWindow'],
      livingRoomWindow: json['livingRoomWindow'],
      balcony: json['balcony'],
      sauna: json['sauna'],
      stove: json['stove'],
      // fixedLampInRoom: json['fixedLampInRoom'],
      information: json['information'],
      reserveButton: json['reserveButton'],
      asun: json['asun'],
      parentLocation: json['parentLocation'],
      apartmentType: json['apartmentType'],
      imageList: List<String>.from(json['imageList']),
      ownUrl: json['ownUrl'],
      updatedAt: json['updatedAt'],
    );
  }

  // Helper method to parse String to double safely
  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      // Remove any non-numeric characters except decimal point and process comma as decimal separator
      String cleanedValue = value.replaceAll(RegExp(r'[^\d.,]'), '').trim();
      // Replace comma with period for decimal
      cleanedValue = cleanedValue.replaceAll(',', '.');
      try {
        return double.parse(cleanedValue);
      } catch (e) {
        return 0.0;
      }
    }
    return 0.0;
  }

  Map<String, dynamic> toJson() {
    return {
      'apartmentId': apartmentId,
      'apartmentStatus': apartmentStatus,
      'vacantFrom': vacantFrom,
      'gender': gender,
      'address': address,
      'rooms': rooms,
      'sizeM2': sizeM2,
      'rent': rent,
      'floor': floor,
      'placeForWashingMachine': placeForWashingMachine,
      'placeForDishwasher': placeForDishwasher,
      'floorMaterial': floorMaterial,
      'bedroomWindow': bedroomWindow,
      'livingRoomWindow': livingRoomWindow,
      'balcony': balcony,
      'sauna': sauna,
      'stove': stove,
      'fixedLampInRoom': fixedLampInRoom,
      'information': information,
      'reserveButton': reserveButton,
      'asun': asun,
      'parentLocation': parentLocation,
      'apartmentType': apartmentType,
      'imageList': imageList,
      'ownUrl': ownUrl,
      'updatedAt': updatedAt,
    };
  }

  ApartmentModel copyWith({
    String? apartmentId,
    String? apartmentStatus,
    String? vacantFrom,
    String? gender,
    String? address,
    double? rooms,
    double? sizeM2,
    double? rent,
    String? floor,
    bool? placeForWashingMachine,
    bool? placeForDishwasher,
    String? floorMaterial,
    String? bedroomWindow,
    String? livingRoomWindow,
    String? balcony,
    String? sauna,
    String? stove,
    String? fixedLampInRoom,
    String? information,
    String? reserveButton,
    String? asun,
    String? parentLocation,
    String? apartmentType,
    List<String>? imageList,
    String? ownUrl,
    String? updatedAt,
  }) {
    return ApartmentModel(
      apartmentId: apartmentId ?? this.apartmentId,
      apartmentStatus: apartmentStatus ?? this.apartmentStatus,
      vacantFrom: vacantFrom ?? this.vacantFrom,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      rooms: rooms ?? this.rooms,
      sizeM2: sizeM2 ?? this.sizeM2,
      rent: rent ?? this.rent,
      floor: floor ?? this.floor,
      placeForWashingMachine: placeForWashingMachine ?? this.placeForWashingMachine,
      placeForDishwasher: placeForDishwasher ?? this.placeForDishwasher,
      floorMaterial: floorMaterial ?? this.floorMaterial,
      bedroomWindow: bedroomWindow ?? this.bedroomWindow,
      livingRoomWindow: livingRoomWindow ?? this.livingRoomWindow,
      balcony: balcony ?? this.balcony,
      sauna: sauna ?? this.sauna,
      stove: stove ?? this.stove,
      fixedLampInRoom: fixedLampInRoom ?? this.fixedLampInRoom,
      information: information ?? this.information,
      reserveButton: reserveButton ?? this.reserveButton,
      asun: asun ?? this.asun,
      parentLocation: parentLocation ?? this.parentLocation,
      apartmentType: apartmentType ?? this.apartmentType,
      imageList: imageList ?? this.imageList,
      ownUrl: ownUrl ?? this.ownUrl,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'apartmentId': apartmentId,
      'apartmentStatus': apartmentStatus,
      'vacantFrom': vacantFrom,
      'gender': gender,
      'address': address,
      'rooms': rooms,
      'sizeM2': sizeM2,
      'rent': rent,
      'floor': floor,
      'placeForWashingMachine': placeForWashingMachine,
      'placeForDishwasher': placeForDishwasher,
      'floorMaterial': floorMaterial,
      'bedroomWindow': bedroomWindow,
      'livingRoomWindow': livingRoomWindow,
      'balcony': balcony,
      'sauna': sauna,
      'stove': stove,
      'fixedLampInRoom': fixedLampInRoom,
      'information': information,
      'reserveButton': reserveButton,
      'asun': asun,
      'parentLocation': parentLocation,
      'apartmentType': apartmentType,
      'imageList': imageList,
      'ownUrl': ownUrl,
      'updatedAt': updatedAt,
    };
  }

  factory ApartmentModel.fromMap(Map<String, dynamic> map) {
    return ApartmentModel(
      apartmentId: map['apartmentId'] as String,
      apartmentStatus: map['apartmentStatus'] as String,
      vacantFrom: map['vacantFrom'] as String,
      gender: map['gender'] as String,
      address: map['address'] as String,
      rooms: map['rooms'] is double ? map['rooms'] as double : _parseDouble(map['rooms']),
      sizeM2: map['sizeM2'] is double ? map['sizeM2'] as double : _parseDouble(map['sizeM2']),
      rent: map['rent'] is double ? map['rent'] as double : _parseDouble(map['rent']),
      floor: map['floor'] as String,
      placeForWashingMachine: map['placeForWashingMachine'] as bool,
      placeForDishwasher: map['placeForDishwasher'] as bool,
      floorMaterial: map['floorMaterial'] as String,
      bedroomWindow: map['bedroomWindow'] as String,
      livingRoomWindow: map['livingRoomWindow'] as String,
      balcony: map['balcony'] as String,
      sauna: map['sauna'] as String,
      stove: map['stove'] as String,
      fixedLampInRoom: map['fixedLampInRoom'] as String,
      information: map['information'] as String,
      reserveButton: map['reserveButton'] as String,
      asun: map['asun'] as String,
      parentLocation: map['parentLocation'] as String,
      apartmentType: map['apartmentType'] as String,
      imageList: List<String>.from((map['imageList'] as List<dynamic>)),
      ownUrl: map['ownUrl'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  // Added to class for reuse
  // static double _parseDouble(dynamic value) {
  //   if (value == null) return 0.0;
  //   if (value is double) return value;
  //   if (value is int) return value.toDouble();
  //   if (value is String) {
  //     // Remove any non-numeric characters except decimal point and process comma as decimal separator
  //     String cleanedValue = value.replaceAll(RegExp(r'[^\d.,]'), '').trim();
  //     // Replace comma with period for decimal
  //     cleanedValue = cleanedValue.replaceAll(',', '.');
  //     try {
  //       return double.parse(cleanedValue);
  //     } catch (e) {
  //       return 0.0;
  //     }
  //   }
  //   return 0.0;
  // }

  @override
  String toString() {
    return 'ApartmentModel(apartmentId: $apartmentId, apartmentStatus: $apartmentStatus, vacantFrom: $vacantFrom, gender: $gender, address: $address, rooms: $rooms, sizeM2: $sizeM2, rent: $rent, floor: $floor, placeForWashingMachine: $placeForWashingMachine, placeForDishwasher: $placeForDishwasher, floorMaterial: $floorMaterial, bedroomWindow: $bedroomWindow, livingRoomWindow: $livingRoomWindow, balcony: $balcony, sauna: $sauna, stove: $stove, fixedLampInRoom: $fixedLampInRoom, information: $information, reserveButton: $reserveButton, asun: $asun, parentLocation: $parentLocation, apartmentType: $apartmentType, imageList: $imageList, ownUrl: $ownUrl, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant ApartmentModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.apartmentId == apartmentId &&
      other.apartmentStatus == apartmentStatus &&
      other.vacantFrom == vacantFrom &&
      other.gender == gender &&
      other.address == address &&
      other.rooms == rooms &&
      other.sizeM2 == sizeM2 &&
      other.rent == rent &&
      other.floor == floor &&
      other.placeForWashingMachine == placeForWashingMachine &&
      other.placeForDishwasher == placeForDishwasher &&
      other.floorMaterial == floorMaterial &&
      other.bedroomWindow == bedroomWindow &&
      other.livingRoomWindow == livingRoomWindow &&
      other.balcony == balcony &&
      other.sauna == sauna &&
      other.stove == stove &&
      other.fixedLampInRoom == fixedLampInRoom &&
      other.information == information &&
      other.reserveButton == reserveButton &&
      other.asun == asun &&
      other.parentLocation == parentLocation &&
      other.apartmentType == apartmentType &&
      listEquals(other.imageList, imageList) &&
      other.ownUrl == ownUrl &&
      other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return apartmentId.hashCode ^
      apartmentStatus.hashCode ^
      vacantFrom.hashCode ^
      gender.hashCode ^
      address.hashCode ^
      rooms.hashCode ^
      sizeM2.hashCode ^
      rent.hashCode ^
      floor.hashCode ^
      placeForWashingMachine.hashCode ^
      placeForDishwasher.hashCode ^
      floorMaterial.hashCode ^
      bedroomWindow.hashCode ^
      livingRoomWindow.hashCode ^
      balcony.hashCode ^
      sauna.hashCode ^
      stove.hashCode ^
      fixedLampInRoom.hashCode ^
      information.hashCode ^
      reserveButton.hashCode ^
      asun.hashCode ^
      parentLocation.hashCode ^
      apartmentType.hashCode ^
      imageList.hashCode ^
      ownUrl.hashCode ^
      updatedAt.hashCode;
  }
}