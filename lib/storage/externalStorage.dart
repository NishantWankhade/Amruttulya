import 'dart:io';
import 'package:excel/excel.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Global/variables.dart';

Future<String> getExternalDocumentPath() async {
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
  Directory _directory = Directory("");
  if (Platform.isAndroid) {
    _directory = Directory("/storage/emulated/0/Amruttulya");
  }

  final exPath = _directory.path;
  print("Saved Path: $exPath");
  await Directory(exPath).create(recursive: true);
  return exPath;
}

Future<String> get _localPath async {
  final String directory = await getExternalDocumentPath();
  return directory;
}

Future<File> writeExcel(List<int> bytes) async {
  final path = await _localPath;
  File file = File('$path/${month[DateTime.now().month]}${DateTime.now().year}.xlsx');
  print("Save file");

  return file
    ..createSync(recursive: true)
    ..writeAsBytesSync(bytes);
}

Future<List<int>> readExcel() async {
  final path = await _localPath;
  File file = File('$path/${month[DateTime.now().month]}${DateTime.now().year}.xlsx');

  if (file.existsSync() == false) {
    print("Don't Exist");
    var excel = Excel.createExcel();
    var bytes = excel.save() ?? [];
    file
      ..createSync(recursive: true)
      ..writeAsBytesSync(bytes);
  }
  return file.readAsBytesSync();
}
