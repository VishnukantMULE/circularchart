import 'package:circularchart/screens/chart/chart_controller.dart';
import 'package:flutter/material.dart';
import 'package:circularchart/screens/chart/widgets/chart_painter.dart';
import 'package:get/get.dart';

class ChartView extends StatelessWidget {
  const ChartView({super.key});

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
            padding: const EdgeInsets.all(60),
            child: Obx(() {
              return CustomPaint(
                painter: ChartPainter(30, controller.data, controller.val.value),
                size: const Size(250, 250),
                child: const SizedBox.square(
                  dimension: 300,
                  child: Center(
                      child: SizedBox(
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


          const SizedBox(height: 50,),

          Obx(() {
            return Column(
              children: [
                Text("Accrued Interest: ${controller.data[0].fillValue.value.toStringAsFixed(2)}"),
                Slider(
                  value: controller.data[0].fillValue.value,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  onChanged: (double value) {
                    controller.updateFill(0, value);
                  },
                ),
                Text("Interest Received: ${controller.data[1].fillValue.value.toStringAsFixed(2)}"),
                Slider(
                  value: controller.data[1].fillValue.value,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  onChanged: (double value) {
                    controller.updateFill(1, value);
                  },
                ),
                Text("Capital Gain: ${controller.data[2].fillValue.value.toStringAsFixed(2)}"),
                Slider(
                  value: controller.data[2].fillValue.value,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  onChanged: (double value) {
                    controller.updateFill(2, value);
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
