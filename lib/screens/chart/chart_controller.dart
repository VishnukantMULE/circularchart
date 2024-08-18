import 'package:circularchart/screens/chart/widgets/chart_painter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'model/pie_chart_data.dart';

class ChartController extends GetxController {
  // Observable value for the overall chart
  RxDouble val = 0.0.obs;

  var data = <PieChartData>[
    PieChartData(Colors.yellow, 20.0, 0.0,Colors.yellow,Colors.yellow,false),
    PieChartData(Colors.orange, 10.0, 0.0,Colors.orange,Colors.orange,false),
    PieChartData(Colors.blueAccent, 70.0, 0.0,Colors.green,Colors.red,false),
  ].obs;


  void updateFill(int index, double value) {
    if (index >= 0 && index < data.length) {
      data[index].fillValue.value = value;
    }
  }


}
