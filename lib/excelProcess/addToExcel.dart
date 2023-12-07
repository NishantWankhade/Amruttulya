import 'dart:io';
import 'package:excel/excel.dart';
import '../storage/externalStorage.dart' as storage;

import '../Global/variables.dart';

Future<void> storeToExcel() async {
  var bytes = await storage.readExcel();
  print("Completed Reading");

  var excel = Excel.decodeBytes(bytes);
  excel.rename(
      "Sheet1", "${DateTime.now().day}_${month[DateTime.now().month]}");

  var fileBytes = excel.save() ?? [];

  if (fileBytes.isNotEmpty) {
    storage.writeExcel(fileBytes);
  }
}
