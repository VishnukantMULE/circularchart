import 'dart:math';
import 'dart:ui';
import 'package:circularchart/sectioned_piechart/chart_view.dart';
import 'package:flutter/material.dart';

class PainterData {
  const PainterData(this.paint, this.radians, this.fillPercentages,
      this.pbColor, this.sbColor, this.isSecondary);

  final Paint paint;
  final double radians;
  final double fillPercentages;
  final Color pbColor;
  final Color sbColor;
  final bool isSecondary;
}

class ChartPainter extends CustomPainter {
  ChartPainter(double strokeWidth, List<PieChartData> data) {
    dataList = data.map((e) {
      final double totalRadians =
          (e.percent.value - _padding) * _percentInRadians;
      final double fillInRadians = (e.fillValue.value / 100) * totalRadians;

      return PainterData(
          Paint()
            ..color = e.color
            ..style = PaintingStyle.stroke
            ..strokeWidth = strokeWidth
            ..strokeCap = StrokeCap.round,
          totalRadians,
          fillInRadians,
          e.pbColor.value,
          e.sbColor.value,
          e.isSecondary.value);
    }).toList();
  }

  static const _percentInRadians = 0.062831853071796; // (2 * pi) / 360
  static const _padding = 4;
  static const _paddingInRadians = _percentInRadians * _padding;
  static const _startAngle = -1.570796 + _paddingInRadians / 25; // -pi/2

  late final List<PainterData> dataList;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    double startAngle = _startAngle;

    for (int i = 0; i < dataList.length; i++) {
      final data = dataList[i];
      final double totalRadians = data.radians;
      final double fillInRadians = data.fillPercentages;
      double arcLength = 0.0;
      if (i == 0) {
        arcLength = totalRadians;
      } else {
        arcLength = totalRadians - fillInRadians;
      }

      final Path outerPath = Path()..addArc(rect, startAngle, arcLength);

      final double dashWidth = data.paint.strokeWidth * 0.004;
      final double dashSpace = data.paint.strokeWidth * 0.99;

      if (i == 2) {
        if (dataList[i].isSecondary == true) {
          final Paint dottedRed = Paint()
            ..color = dataList[i].sbColor
            ..style = PaintingStyle.stroke
            ..strokeWidth =
                data.paint.strokeWidth - (data.paint.strokeWidth * 0.04)
            ..strokeCap = StrokeCap.round;

          _drawDottedArc(canvas, outerPath, dottedRed, dashWidth, dashSpace);
        } else {
          final Paint border = Paint()
            ..color = dataList[i].pbColor
            ..style = PaintingStyle.stroke
            ..strokeWidth =
                data.paint.strokeWidth - (data.paint.strokeWidth * 0.04)
            ..strokeCap = StrokeCap.round;
          canvas.drawPath(outerPath, border);
        }
      } else {
        canvas.drawPath(outerPath, data.paint);
      }

      final double endAngle = startAngle + arcLength;

      // White Arc for Add Border Effect
      const double arcBorder = 5.0;
      final whitePaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = data.paint.strokeWidth - arcBorder;
      final whitePath = Path()..addArc(rect, startAngle, totalRadians);
      canvas.drawPath(whitePath, whitePaint);

      // Fill by Color ex- fill 10% ,20% that Stroke by that Stroke color
      if (i == 0) {
        final fillPaint = Paint()
          ..color = data.paint.color
          ..strokeWidth = data.paint.strokeWidth
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke;

        final fillPath = Path()..addArc(rect, startAngle, fillInRadians);
        canvas.drawPath(fillPath, fillPaint);
        startAngle = startAngle + totalRadians + _paddingInRadians;
      } else {
        final fillPaint = Paint()
          ..color = data.paint.color
          ..strokeWidth = data.paint.strokeWidth
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke;

        final fillPath = Path()..addArc(rect, endAngle, fillInRadians);
        canvas.drawPath(fillPath, fillPaint);
        startAngle = startAngle + totalRadians + _paddingInRadians;
      }

      // Outer Border
      final obPaint = Paint()
        ..color = Colors.black12
        ..style = PaintingStyle.stroke
        ..strokeWidth =
            data.paint.strokeWidth - (data.paint.strokeWidth * 0.97);

      final obCompletePaint = Paint()
        ..color = Colors.black12
        ..style = PaintingStyle.stroke
        ..strokeWidth =
            data.paint.strokeWidth - (data.paint.strokeWidth * 0.97);

      final obRect = rect.inflate(data.paint.strokeWidth);
      final obCompleteRect = rect.inflate(data.paint.strokeWidth);

      final obPath = Path()..addArc(obRect, 35.5, 40);
      final obCompletePath = Path()..addArc(obCompleteRect, 0, 100);

      canvas.drawPath(obCompletePath, obCompletePaint);
      canvas.drawPath(obPath, obPaint);

      // Inner Border
      final ibPaint = Paint()
        ..color = Colors.black12
        ..style = PaintingStyle.stroke
        ..strokeWidth =
            data.paint.strokeWidth - (data.paint.strokeWidth * 0.95);

      final ibCompletePaint = Paint()
        ..color = Colors.black12
        ..style = PaintingStyle.stroke
        ..strokeWidth =
            data.paint.strokeWidth - (data.paint.strokeWidth * 0.97);

      final ibRect = rect.deflate(data.paint.strokeWidth);
      final ibCompleteRect = rect.deflate(data.paint.strokeWidth);

      final ibPath = Path()..addArc(ibRect, 35.6, 40);
      final ibCompletePath = Path()..addArc(ibCompleteRect, 0, 100);

      canvas.drawPath(ibCompletePath, ibCompletePaint);
      canvas.drawPath(ibPath, ibPaint);
    }
  }

  void _drawDottedArc(Canvas canvas, Path path, Paint paint, double dashWidth,
      double dashSpace) {
    final PathMetrics pathMetrics = path.computeMetrics();
    final Path dashPath = Path();
    final Paint dashPaint = Paint()
      ..color = paint.color
      ..style = paint.style
      ..strokeWidth = paint.strokeWidth
      ..strokeCap = StrokeCap.round;

    for (final pathMetric in pathMetrics) {
      final double length = pathMetric.length;
      double distance = 0.0;

      while (distance < length) {
        final double start = distance;
        final double end = min(distance + dashWidth, length);
        final Path segment = pathMetric.extractPath(start, end);

        dashPath.addPath(segment, Offset.zero);
        distance = distance + dashWidth + dashSpace;
      }
    }

    canvas.drawPath(dashPath, dashPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
