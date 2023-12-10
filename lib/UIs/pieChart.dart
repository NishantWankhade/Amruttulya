import 'dart:math';
import 'package:ashwini_amruttulya/classes/itm.dart';
import 'package:ashwini_amruttulya/storage/externalStorage.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Global/variables.dart';

class PieChartPage extends StatefulWidget {
  const PieChartPage({
    super.key,
    required this.chartItms,
  });
  final List<Item> chartItms;

  @override
  State<PieChartPage> createState() => _PieChartPageState(chartItms: chartItms);
}

class _PieChartPageState extends State<PieChartPage> {
  _PieChartPageState({required this.chartItms});
  List<Item> chartItms;

  var loaded;
  String status = "Loading...";
  Random random = Random();
  String _date = "";

  @override
  void initState() {
    if (chartItms.length != 0) {
      setState(() {
        loaded = true;
      });
    }
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
