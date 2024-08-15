import 'package:get/get.dart';
import 'package:flutter/material.dart';

class PieChartData {
  PieChartData(this.color, double percent, double fillValue)
      : percent = percent.obs,
        fillValue = fillValue.obs;

  final Color color;
  final RxDouble percent;
  final RxDouble fillValue;
}
