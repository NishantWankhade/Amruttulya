import 'package:excel/excel.dart';
import '../storage/externalStorage.dart' as storage;

import '../Global/variables.dart';

Future<bool> storeToExcel() async {
  var bytes = await storage.readExcel();
  print("Completed Reading");

  var excel = Excel.decodeBytes(bytes);

  excel.rename(
      "Sheet1", "${DateTime.now().day}_${month[DateTime.now().month]}");

  Sheet sheetObject =
      excel["${DateTime.now().day}_${month[DateTime.now().month]}"];

  var itemNameCell = sheetObject.cell(CellIndex.indexByString('A1'));
  itemNameCell.value = null;
  itemNameCell.value = TextCellValue('Item Name');
  itemNameCell.cellStyle = CellStyle(
    bold: true,
    textWrapping: TextWrapping.WrapText,
    bottomBorder: Border(borderStyle: BorderStyle.MediumDashed),
  );

  var countCell = sheetObject.cell(CellIndex.indexByString('B1'));
  countCell.value = null;
  countCell.value = TextCellValue('Count');
  countCell.cellStyle = CellStyle(
    bold: true,
    textWrapping: TextWrapping.WrapText,
    bottomBorder: Border(borderStyle: BorderStyle.MediumDashed),
  );

  current_transaction.forEach((
    key,
    value,
  ) {
    int rowNumber = findItm(key, sheetObject);
    int maxRow = sheetObject.maxRows;

    if (rowNumber >= maxRow) {
      sheetObject.appendRow([
        TextCellValue(value.itm_name),
        TextCellValue(value.itm_qnt.toString())
      ]);
    } else {
      print("Exists");
      var itm = sheetObject.row(rowNumber)[1];
      int prevVal = int.parse(itm!.value.toString()) + value.itm_qnt;
      itm!.value = TextCellValue(prevVal.toString());
    }
  });

  var fileBytes = excel.save() ?? [];

  if (fileBytes.isNotEmpty) {
    storage.writeExcel(fileBytes);
    return true;
  }
  return false;
}

int findItm(String name, Sheet sheetObject) {
  int rows = sheetObject.maxRows;
  int col = 0;

  for (int i = 0; i < rows; i++) {
    var val = sheetObject.row(i)[col];
    if (val!.value.toString() == name) {
      return i;
    }
  }

  return rows;
}
