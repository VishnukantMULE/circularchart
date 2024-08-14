import 'package:circularchart/screens/chart/widgets/chart_painter.dart';
import 'package:flutter/material.dart';

class ChartView extends StatelessWidget {
  const ChartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Circular Chart",
          style: TextStyle(fontSize: 15),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          CustomPaint(
            painter: ChartPainter(),
          )
        ],
      ),
    );
  }
}
