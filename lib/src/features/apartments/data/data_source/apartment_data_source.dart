import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:psoas_va_mobile/src/common/apartment_to_hive_extension.dart';

import '../models/apartment_model.dart';
import '../models/apartment_hive_model.dart'; // Import your Hive model

final dio = Dio();

class ApartmentDataSource {
  // static const String _boxName = 'apartmentsBox';
  static const String _boxHiveName = 'apartmentsHiveBox'; // Different name

  Future<List<ApartmentModel>> getApartments() async {
    // Open the box with the correct type
    // Check if the box is already open

// Now open with correct type
    final box = Hive.box<ApartmentHiveModel>(_boxHiveName);

    // clear hive cache
    // await box.clear();

    try {
      final response = await dio
          .get('http://10.0.2.2:3000/api/ouluva/get_all_vacant_apartments');

      if (response.statusCode == 200) {
        try {
          final List<dynamic> data = response.data['vacantApartmentDetails'];
          final List<ApartmentModel> apiApartments =
              data.map((e) => ApartmentModel.fromJson(e)).toList();

          // Check if we need to update the cached data
          if (box.length != apiApartments.length) {
            await box.clear();

            // Convert each ApartmentModel to ApartmentHiveModel before storing
            for (final apartmentModel in apiApartments) {
              // Convert to Hive model using the extension method
              final hiveModel = apartmentModel.toHiveModel();
              await box.add(hiveModel);
            }

            // Return the API models directly since we just fetched them
            return apiApartments;
          } else {
            // clear the box

            print('Hive data updated');
            print('Cached data: ${box.values.toList()}');
            // Convert Hive models back to ApartmentModel when reading
            return box.values
                .map((hiveModel) => hiveModel.toApartmentModel())
                .toList();
          }
        } catch (e) {
          print('Error parsing data: $e');
          throw Exception('Failed to parse apartments data: $e');
        }
      } else {
        throw Exception('Failed to load apartments: ${response.statusCode}');
      }
    } catch (e) {
      // If there's a network error, try to return cached data if available
      if (box.isNotEmpty) {
        print('Network error, returning cached data: $e');
        return box.values
            .map((hiveModel) => hiveModel.toApartmentModel())
            .toList();
      }
      throw Exception('Failed to load apartments: $e');
    } finally {
      // just return the cached data
      return box.values
          .map((hiveModel) => hiveModel.toApartmentModel())
          .toList();
    }
  }

  
}
