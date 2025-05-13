import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:psoas_va_mobile/src/common/apartment_to_hive_extension.dart';
import 'package:psoas_va_mobile/src/features/apartments/data/models/apartment_hive_model.dart';
import 'package:psoas_va_mobile/src/features/apartments/data/models/dream_apartment_model.dart';
import 'package:psoas_va_mobile/src/features/apartments/utils/apartment_updater.dart';
import 'package:psoas_va_mobile/src/features/authentication/services/auth_service.dart';

import '../data_source/apartment_data_source.dart';
import '../models/apartment_model.dart';

class ApartmentRepo {
  final ApartmentDataSource dataSource;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _boxName =
      'apartmentsHiveBox'; // Use the same box name you defined

  ApartmentRepo(this.dataSource);

  Future<Map<String, List<ApartmentModel>>> getApartments() async {

    // Open the box with the correct type
    // final apartmentHiveBox = Hive.box(_boxName).values.toList();
    List<ApartmentModel> apartments = await dataSource.getApartments();

    // loop through the apartments and print out the apartment type
    for (var apartment in apartments) {
      print('Apartment type: ${apartment.apartmentType}');
    }

  
    final Map<String, List<ApartmentModel>> apartmentsByType = {
      'studio': [],
      'family': [],
      'shared': [],
    };

    for (var apartment in apartments) {
      if (apartment.apartmentType == 'studio') {
        apartmentsByType['studio']!.add(apartment);
      } else if (apartment.apartmentType == 'family') {
        apartmentsByType['family']!.add(apartment);
      } else if (apartment.apartmentType == 'shared') {
        apartmentsByType['shared']!.add(apartment);
      }
    }

    // update hive model with data from database
    // await updateApartment();
    print('Apartments: $apartmentsByType');

    return apartmentsByType;
  }

  // get apartments from hive storage
  Future<Map<String, List<ApartmentModel>>> getHiveApartments() async {
    final box = Hive.box<ApartmentHiveModel>(_boxName);
    final List<ApartmentModel> apartments = box.values
        .map((hiveModel) => hiveModel.toApartmentModel())
        .toList();
    
    final Map<String, List<ApartmentModel>> apartmentsByType = {
      'studio': [],
      'family': [],
      'shared': [],
    };

    for (var apartment in apartments) {
      if (apartment.apartmentType == 'studio') {
        apartmentsByType['studio']!.add(apartment);
      } else if (apartment.apartmentType == 'family') {
        apartmentsByType['family']!.add(apartment);
      } else if (apartment.apartmentType == 'shared') {
        apartmentsByType['shared']!.add(apartment);
      }
    }

    return apartmentsByType;
  }

  // write dream apartment data to firestore
  Future<void> dreamApartment(DreamApartmentModel dreamApartment) async {
    final currentUserId = AuthService().currentUser!.uid;
    try {
      await _firestore.collection('dream_apartments').doc(currentUserId).set(dreamApartment.toMap());
    } catch (e) {
      throw Exception('Failed to write dream apartment data');
    }
  }

  // notify me function
  Future<void> notifyMe(ApartmentModel apartment) async {
    final currentUserId = AuthService().currentUser!.uid;
    
    try {
      // Fixed collection name to be consistent with other functions (dream_apartments instead of dream_apartment)
      await _firestore
        .collection('dream_apartments')
        .doc(currentUserId)
        .collection(apartment.apartmentType)
        .doc(apartment.apartmentId)
        .set({
          ...apartment.toMap(),
          'createdAt': FieldValue.serverTimestamp(),
          'notified': false
        });
      
    } catch (e) {
      print("################################");
      print('Error notifying me: ${e.toString()}');
      print("################################");
      throw Exception('Failed to save notification preference: ${e.toString()}');
    }
  }

  
}
