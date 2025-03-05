
// function to update apartment
import '../data/data_source/apartment_data_source.dart';

Future<void> updateApartment() async {
  final dataSource = ApartmentDataSource();
  await dataSource.getApartments();
}