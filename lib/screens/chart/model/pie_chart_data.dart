import 'package:get/get.dart';
import 'package:flutter/material.dart';

class PieChartData {
  PieChartData(Color color, double percent, double decrease)
      : color = color,
        percent = percent.obs,
        decrease = decrease.obs;

  final Color color;
  final RxDouble percent;
  final RxDouble decrease;
}
