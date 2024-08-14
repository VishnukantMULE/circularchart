import 'package:circularchart/screens/chart/widgets/chart_painter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import 'model/pie_chart_data.dart';

class ChartController extends GetxController {
  RxDouble val = 0.0.obs;
  RxInt val1 = 0.obs;
  var data = <PieChartData>[
    PieChartData(Colors.red, 20.0, 1),
    PieChartData(Colors.green, 10.0, 2),
    PieChartData(Colors.blue, 70.0, 3),
  ].obs;
  void increase() {
    val.value = val.value + 0.1;
    print("value : ${val.value}");
  }

  void decrease() {
    val.value = val.value - 0.1;
    print("value : ${val.value}");
  }
}
