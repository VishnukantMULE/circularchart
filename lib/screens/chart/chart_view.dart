import 'package:circularchart/screens/chart/chart_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circularchart/screens/chart/widgets/chart_painter.dart';
import 'package:get/get.dart';

import 'model/pie_chart_data.dart';

class ChartView extends StatelessWidget {
  ChartView({
    super.key,
  });

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
                painter:
                    ChartPainter(28, controller.data, controller.val.value),
                size: const Size(300, 300),
                child: SizedBox.square(
                  dimension: 360, // Using the correct dimension
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
          // Obx(() {
          //   return Slider(
          //       value: controller.data[0].decrease.value,
          //       max: 1,
          //       divisions: 10,
          //       onChanged: (double value) {
          //         print("value : ${value}");
          //         // controller.data[0].decrease.value = value;
          //       });
          // }),
          Obx(() {
            return Slider(
                value: controller.val.value,
                max: 1,
                divisions: 10,
                onChanged: (double value) {
                  print("value : ${value}");
                  controller.val.value = value;
                });
          }),
        ],
      ),
    );
  }
}
