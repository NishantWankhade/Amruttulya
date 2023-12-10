import 'package:ashwini_amruttulya/UIs/pieChart.dart';
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
    showChart();
  }

  Future<void> showChart() async {
    setState(() {
      loaded = false;
      chartItms.clear();
    });
    var bytes = await readExcel();
    excel = Excel.decodeBytes(bytes);

    _date = _day + "/" + _month;

    sheetObj = excel["${DateTime.now().day}_${month[DateTime.now().month]}"];

    int row = sheetObj.maxRows;

    if (row < 1) {
      setState(() {
        status = "No Data";
        loaded = true;
      });
      return;
    }

    for (int i = 1; i < row; i++) {
      Item value = Item();

      value.itm_name = sheetObj.row(i)[0]!.value.toString();
      value.itm_qnt = int.parse(sheetObj.row(i)[1]!.value.toString());
      chartItms.add(value);
    }
    setState(() {
      loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Total Sales on ${_date}"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PieChartPage(
                      chartItms: this.chartItms,
                    ),
                  ),
                );
              },
              icon: Icon(Icons.pie_chart_rounded),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: chartItms.length,
                itemBuilder: (context, index) {
                  Item item = chartItms[index];
                  return buildListRow(item.itm_name, item.itm_qnt.toString());
                },
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
