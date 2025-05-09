import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:psoas_va_mobile/src/common/apartment_to_hive_extension.dart';
import '../models/apartment_model.dart';
import '../models/apartment_hive_model.dart';

final dio = Dio();

class ApartmentDataSource {
  static const String _boxHiveName = 'apartmentsHiveBox';

  Future<List<ApartmentModel>> getApartments() async {
    // Get reference to the Hive box
    final box = Hive.box<ApartmentHiveModel>(_boxHiveName);
    
    try {
      // Attempt to fetch data from API
      final response = await dio.get('https://psoas-va-ultimate.onrender.com/api/ouluva/get_all_vacant_apartments');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['vacantApartmentDetails'];
        final List<ApartmentModel> apiApartments = 
            data.map((e) => ApartmentModel.fromJson(e)).toList();
        
        print("###################################");
        print("API Apartments: $apiApartments");
        print("###################################");
        
        // Update cache if new data is different
        await _updateCache(box, apiApartments);
        return apiApartments;
      } else {
        throw Exception('Failed to load apartments: ${response.statusCode}');
      }
    } catch (e) {
      // On network error, fall back to cached data if available
      if (box.isNotEmpty) {
        print('Network error, returning cached data: $e');
        return _getCachedApartments(box);
      }
      throw Exception('Failed to load apartments: $e');
    }
  }
  
  // Helper method to update the cache
  Future<void> _updateCache(
    Box<ApartmentHiveModel> box,
    List<ApartmentModel> apiApartments
  ) async {
    await box.clear();
    
    // Convert and store each apartment model
    for (final apartmentModel in apiApartments) {
      final hiveModel = apartmentModel.toHiveModel();
      await box.add(hiveModel);
    }
  }
  
  // Helper method to retrieve cached apartments
  List<ApartmentModel> _getCachedApartments(Box<ApartmentHiveModel> box) {
    return box.values
        .map((hiveModel) => hiveModel.toApartmentModel())
        .toList();
  }
}