// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

class DreamApartmentModel {
  final String location;
  final int minRent;
  final int maxRent;
  final String rooms;
  final int floor;
  final String apartmentType;
  final bool hasSauna;
  

  DreamApartmentModel({
    required this.location,
    required this.minRent,
    required this.maxRent,
    required this.rooms,
    required this.floor,
    required this.apartmentType,
    required this.hasSauna,
  });

  DreamApartmentModel copyWith({
    String? location,
    int? minRent,
    int? maxRent,
    String? rooms,
    int? floor,
    String? apartmentType,
    bool? hasSauna,
  }) {
    return DreamApartmentModel(
      location: location ?? this.location,
      minRent: minRent ?? this.minRent,
      maxRent: maxRent ?? this.maxRent,
      rooms: rooms ?? this.rooms,
      floor: floor ?? this.floor,
      apartmentType: apartmentType ?? this.apartmentType,
      hasSauna: hasSauna ?? this.hasSauna,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'location': location,
      'minRent': minRent,
      'maxRent': maxRent,
      'rooms': rooms,
      'floor': floor,
      'apartmentType': apartmentType,
      'hasSauna': hasSauna,
    };
  }

  factory DreamApartmentModel.fromMap(Map<String, dynamic> map) {
    return DreamApartmentModel(
      location: map['location'] as String,
      minRent: map['minRent'] as int,
      maxRent: map['maxRent'] as int,
      rooms: map['rooms'] as String,
      floor: map['floor'] as int,
      apartmentType: map['apartmentType'] as String,
      hasSauna: map['hasSauna'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory DreamApartmentModel.fromJson(String source) => DreamApartmentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DreamApartmentModel(location: $location, minRent: $minRent, maxRent: $maxRent, rooms: $rooms, floor: $floor, apartmentType: $apartmentType, hasSauna: $hasSauna)';
  }

  @override
  bool operator ==(covariant DreamApartmentModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.location == location &&
      other.minRent == minRent &&
      other.maxRent == maxRent &&
      other.rooms == rooms &&
      other.floor == floor &&
      other.apartmentType == apartmentType &&
      other.hasSauna == hasSauna;
  }

  @override
  int get hashCode {
    return location.hashCode ^
      minRent.hashCode ^
      maxRent.hashCode ^
      rooms.hashCode ^
      floor.hashCode ^
      apartmentType.hashCode ^
      hasSauna.hashCode;
  }
}
