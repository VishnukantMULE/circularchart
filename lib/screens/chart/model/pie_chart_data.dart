import 'package:get/get.dart';
import 'package:flutter/material.dart';

class PieChartData {
  PieChartData(this.color, double percent, double fillValue,Color pbColor,Color sbColor,bool isSecondary)
      : percent = percent.obs,
        fillValue = fillValue.obs,
        pbColor=pbColor.obs,
        sbColor=sbColor.obs,
        isSecondary=isSecondary.obs;

  final Color color;
  final RxDouble percent;
  final RxDouble fillValue;
  final Rx<Color> pbColor;
  final Rx<Color> sbColor;
  final RxBool isSecondary;
}
