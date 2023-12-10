import 'dart:math';
import 'package:ashwini_amruttulya/classes/itm.dart';
import 'package:ashwini_amruttulya/storage/externalStorage.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Global/variables.dart';

class PieChartPage extends StatefulWidget {
  const PieChartPage({super.key});

  @override
  State<PieChartPage> createState() => _PieChartPageState();
}

class _PieChartPageState extends State<PieChartPage> {
  var excel;
  late Sheet sheetObj;
  var loaded;
  String status = "Loading...";
  List<Item> chartItms = [];
  Random random = Random();
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

    _date = _day + "-" + _month;

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
        title: Text("Pie Chart"),
      ),
      body: loaded == false
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(status),
                ),
                CircularProgressIndicator(),
              ],
            ))
          : Center(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: SfCircularChart(
                  series: <CircularSeries>[
                    PieSeries<Item, String>(
                      dataSource: chartItms,
                      pointColorMapper: (Item data, _) => Color.fromRGBO(
                          random.nextInt(150) + 60,
                          random.nextInt(150) + 60,
                          random.nextInt(150) + 60,
                          1),
                      xValueMapper: (Item data, _) => data.itm_name,
                      yValueMapper: (Item data, _) => data.itm_qnt,
                      dataLabelMapper: (Item data, _) =>
                          "${data.itm_name} :- ${data.itm_qnt}",
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                  title: ChartTitle(text: _date),
                ),
              ),
            ),
    );
  }
}
