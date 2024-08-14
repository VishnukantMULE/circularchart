import 'dart:math';

import 'package:circularchart/screens/chart/chart_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/pie_chart_data.dart';

class _PainterData {
  const _PainterData(this.paint, this.radians, this.decrease);

  final Paint paint;
  final double radians;
  final double decrease;
}

class ChartPainter extends CustomPainter {
  ChartPainter(double strokeWidth, List<PieChartData> data, double val) {
    // convert chart data to painter data
    dataList = data
        .map((e) => _PainterData(
              Paint()
                ..color = e.color
                ..style = PaintingStyle.stroke
                ..strokeWidth = strokeWidth
                ..strokeCap = StrokeCap.round,
              (e.percent.value - _padding) * _percentInRadians,
              e.decrease.value,
            ))
        .toList();
  }

  static const _percentInRadians = 0.062831853071796;
  // this is the gap between strokes in percent
  static const _padding = 4;
  static const _paddingInRadians = _percentInRadians * _padding;
  // 0 radians is to the right, but since we want to start from the top
  // we'll use -90 degrees in radians
  static const _startAngle = -1.570796 + _paddingInRadians / 25;
  var controller = Get.find<ChartController>();

  late final List<_PainterData> dataList;
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    double startAngle = _startAngle;

    for (final data in dataList) {
      final path = Path()..addArc(rect, startAngle, data.radians);
      var startAngle2 = startAngle + data.decrease;
      var radians = data.radians - data.decrease;
      if (radians < 0) {
        radians = 0;
      }

      startAngle += data.radians + _paddingInRadians;

      canvas.drawPath(path, data.paint);
      final paint2 = Paint()
        ..color = Colors.yellow
        ..strokeWidth = data.paint.strokeWidth - 5
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      final path2 = Path()..addArc(rect, startAngle2, radians);
      startAngle2 += radians + _paddingInRadians;
      canvas.drawPath(path2, paint2);

      // canvas.drawArc(
      //     rect, startAngle2 + 0.2, data.radians - 0.2, false, paint2);
      // canvas.drawCircle(Offset(150, 20), 180, data.paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
    // return oldDelegate != this;
    // throw UnimplementedError();
  }
}
