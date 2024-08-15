import 'dart:math';

import 'package:circularchart/screens/chart/chart_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/pie_chart_data.dart';

class _PainterData {
  const _PainterData(this.paint, this.radians, this.decreaseInPercent);

  final Paint paint;
  final double radians;
  final double decreaseInPercent;
}

class ChartPainter extends CustomPainter {
  ChartPainter(double strokeWidth, List<PieChartData> data, double val) {
    dataList = data.map((e) {
      final double totalRadians = (e.percent.value-_padding) * _percentInRadians;
      final double decreaseInRadians = (e.decrease.value / 100) * totalRadians;

      return _PainterData(
        Paint()
          ..color = e.color
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round,
        totalRadians,
        decreaseInRadians,
      );
    }).toList();
  }

  static const _percentInRadians = 0.062831853071796; // (2 * pi) / 360
  static const _padding = 4;

  static const _paddingInRadians = _percentInRadians * _padding; // Padding between slices
  static const _startAngle = -1.570796 + _paddingInRadians / 25;

  late final List<_PainterData> dataList;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    double startAngle = _startAngle;

    for (final data in dataList) {
      final path = Path()..addArc(rect, startAngle, data.radians - data.decreaseInPercent);
      final endAngle = startAngle + (data.radians - data.decreaseInPercent);

      canvas.drawPath(path, data.paint);

      final Paint decreasePaint = Paint()
        ..color = Colors.yellow
        ..strokeWidth = data.paint.strokeWidth - 5
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      final Path decreasePath = Path()..addArc(rect, endAngle, data.decreaseInPercent);
      canvas.drawPath(decreasePath, decreasePaint);

      startAngle += data.radians + _paddingInRadians;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
