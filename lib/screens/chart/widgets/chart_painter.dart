import 'package:flutter/material.dart';
import '../model/pie_chart_data.dart';

///  ib = inner border
///  ob = outer border
///  ibComplete = inner border complete 100%
///  obComplete = outer border complete 100%

class PainterData {
  const PainterData(this.paint, this.radians, this.fillPercentages);

  final Paint paint;
  final double radians;
  final double fillPercentages;
}



class ChartPainter extends CustomPainter {

  ChartPainter(double strokeWidth, List<PieChartData> data, double val) {
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
      );
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

    for (final data in dataList) {

      final outerPath = Path()
        ..addArc(rect, startAngle, data.radians - data.fillPercentages);
      final endAngle = startAngle + (data.radians - data.fillPercentages);
      canvas.drawPath(outerPath, data.paint);




      /// white Arc for Add Border Effect
      /// arcBorder -
      const double arcBorder=5.0;
      final whitePaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = data.paint.strokeWidth - arcBorder;
      final whitePath = Path()..addArc(rect, startAngle, data.radians);
      canvas.drawPath(whitePath, whitePaint);
      startAngle = startAngle + data.radians + _paddingInRadians;




      /// Fill by Color ex- fill 10% ,20% that Stroke by that Stroke color

      final fillPaint = Paint()
        ..color = data.paint.color
        ..strokeWidth = data.paint.strokeWidth
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      final fillPath = Path()
        ..addArc(rect, endAngle, data.fillPercentages);
      canvas.drawPath(fillPath, fillPaint);





      /// Outer Border ///

      final obPaint = Paint()
        ..color = Colors.black12
        ..style = PaintingStyle.stroke
        ..strokeWidth = data.paint.strokeWidth - 29.5;

      final obCompletePaint = Paint()
        ..color = Colors.black12
        ..style = PaintingStyle.stroke
        ..strokeWidth = data.paint.strokeWidth - 29.8;

      final obRect = rect.inflate(data.paint.strokeWidth);
      final obCompleteRect = rect.inflate(data.paint.strokeWidth);

      final obPath = Path()..addArc(obRect, 35.5, 40);
      final obCompletePath = Path()..addArc(obCompleteRect, 0, 100);

      canvas.drawPath(obCompletePath, obCompletePaint);
      canvas.drawPath(obPath, obPaint);



      /// Inner Border ///

      final ibPaint = Paint()
        ..color = Colors.black12
        ..style = PaintingStyle.stroke
        ..strokeWidth = data.paint.strokeWidth - 29.5;

      final ibCompletePaint = Paint()
        ..color = Colors.black12
        ..style = PaintingStyle.stroke
        ..strokeWidth = data.paint.strokeWidth - 29.8;

      final ibRect = rect.deflate(data.paint.strokeWidth);
      final ibCompleteRect = rect.deflate(data.paint.strokeWidth);

      final ibPath = Path()..addArc(ibRect, 35.6, 40);
      final ibCompletePath = Path()..addArc(ibCompleteRect, 0, 100);

      canvas.drawPath(ibCompletePath, ibCompletePaint);
      canvas.drawPath(ibPath, ibPaint);

    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
