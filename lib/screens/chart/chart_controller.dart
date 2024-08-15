import 'package:circularchart/screens/chart/widgets/chart_painter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'model/pie_chart_data.dart';

class ChartController extends GetxController {
  // Observable value for the overall chart
  RxDouble val = 0.0.obs;

  // Observable list of PieChartData
  var data = <PieChartData>[
    PieChartData(Colors.red, 20.0, 0.0),  // Initial decrease values
    PieChartData(Colors.green, 10.0, 0.0),
    PieChartData(Colors.blue, 70.0, 0.0),
  ].obs;

  // Update decrease value for a specific item
  void updateDecrease(int index, double value) {
    if (index >= 0 && index < data.length) {
      data[index].decrease.value = value;
    }
  }

  // Increase or decrease the global value
  void increase() {
    val.value += 0.1;
    print("value : ${val.value}");
  }

  void decrease() {
    val.value -= 0.1;
    print("value : ${val.value}");
  }
}
