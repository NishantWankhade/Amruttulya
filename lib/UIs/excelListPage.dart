import 'package:ashwini_amruttulya/classes/itm.dart';
import 'package:ashwini_amruttulya/storage/externalStorage.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

import '../Global/variables.dart';

class ExcelListPage extends StatefulWidget {
  const ExcelListPage({super.key});

  @override
  State<ExcelListPage> createState() => _ExcelListPageState();
}

class _ExcelListPageState extends State<ExcelListPage> {
  var excel;
  late Sheet sheetObj;
  var loaded;
  String status = "Loading...";
  List<Item> chartItms = [];
  String _day = DateTime.now().day.toString();
  String _month = month[DateTime.now().month].toString();
  String _date = "";

  @override
  void initState() {
    showChart(_day, _month);
  }

  Future<void> showChart(day, month) async {
    setState(() {
      loaded = false;
      chartItms.clear();
    });
    var bytes = await readExcel();
    excel = Excel.decodeBytes(bytes);

    _date = day + "/" + month;

    sheetObj = excel["${day}_${month}"];

    int row = sheetObj.maxRows;

    if (row < 1) {
      setState(() {
        status = "No Data";
      });
      return;
    }

    for (int i = 1; i < row; i++) {
      Item value = Item();

      value.itm_name = sheetObj.row(i)[0]!.value.toString();
      value.itm_qnt = int.parse(sheetObj.row(i)[1]!.value.toString());
      chartItms.add(value);
    }
    print(chartItms.length);
    setState(() {
      loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Total Sales"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () async {
                DateTime? time = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2023, 12, 2),
                  lastDate: DateTime.now(),
                );
                setState(() {
                  showChart(time!.day.toString(), month[time.month]);
                });
              },
              icon: Icon(Icons.date_range_rounded),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _date,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: chartItms.length,
                      itemBuilder: (context, index) {
                        Item item = chartItms[index];
                        return buildListRow(
                            item.itm_name, item.itm_qnt.toString());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListRow(String itm_name, String itm_qnt,
      {double fontSize = 18, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              itm_name,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              itm_qnt,
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
