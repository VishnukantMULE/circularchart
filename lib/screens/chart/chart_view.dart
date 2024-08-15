import 'package:circularchart/screens/chart/chart_controller.dart';
import 'package:flutter/material.dart';
import 'package:circularchart/screens/chart/widgets/chart_painter.dart';
import 'package:get/get.dart';

import 'model/pie_chart_data.dart';

class ChartView extends StatelessWidget {
  ChartView({super.key});

  @override
  Widget build(BuildContext context) {
    final ChartController controller = Get.put(ChartController());

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
          Padding(
            padding: const EdgeInsets.all(30),
            child: Obx(() {
              return CustomPaint(
                painter: ChartPainter(28, controller.data, controller.val.value),
                size: const Size(300, 300),
                child: SizedBox.square(
                  dimension: 360,
                  child: Center(
                      child: Container(
                        width: 200,
                        height: 80,
                        child: Column(
                          children: [
                            Text(
                              "₹ 1,250",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Current Values",
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )),
                ),
              );
            }),
          ),
          // Sliders for adjusting decrease values of pie chart items
          Obx(() {
            return Column(
              children: [
                Text("Adjust Red Slice Decrease: ${controller.data[0].decrease.value.toStringAsFixed(2)}"),
                Slider(
                  value: controller.data[0].decrease.value,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  onChanged: (double value) {
                    controller.updateDecrease(0, value);
                  },
                ),
                Text("Adjust Green Slice Decrease: ${controller.data[1].decrease.value.toStringAsFixed(2)}"),
                Slider(
                  value: controller.data[1].decrease.value,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  onChanged: (double value) {
                    controller.updateDecrease(1, value);
                  },
                ),
                Text("Adjust Blue Slice Decrease: ${controller.data[2].decrease.value.toStringAsFixed(2)}"),
                Slider(
                  value: controller.data[2].decrease.value,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  onChanged: (double value) {
                    controller.updateDecrease(2, value);
                  },
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
