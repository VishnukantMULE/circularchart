import 'package:circularchart/sectioned_piechart/chart_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const CircularChart());
}

class CircularChart extends StatefulWidget {
  const CircularChart({super.key});

  @override
  State<CircularChart> createState() => _CircularChartState();
}

class _CircularChartState extends State<CircularChart> {
  var data = <PieChartData>[
    PieChartData(Colors.orangeAccent, 20.0, 0.0, Colors.orangeAccent,
        Colors.orangeAccent, false),
    PieChartData(Colors.deepOrange, 10.0, 0.0, Colors.deepOrange,
        Colors.deepOrange, false),
    PieChartData(Colors.blueAccent, 70.0, 0.0, Colors.green, Colors.red, true),
  ].obs;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChartView(
        data: data,
        cleanPrice: 600,
        capitalLP: 600,
        accruedInterest: 600,
        interestReceived: 700,
        isCapitalLoss: true,
        currentValues: 1250,
      ),
    );
  }
}
