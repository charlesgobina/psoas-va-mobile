import 'package:hive/hive.dart';

void clearHiveCache(String boxName) async {
  var box = await Hive.openBox(boxName);

  await box.deleteFromDisk();

  await box.close();
}
