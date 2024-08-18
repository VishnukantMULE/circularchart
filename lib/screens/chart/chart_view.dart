import 'package:circularchart/screens/chart/chart_controller.dart';
import 'package:circularchart/screens/chart/widgets/lables_data.dart';
import 'package:flutter/material.dart';
import 'package:circularchart/screens/chart/widgets/chart_painter.dart';
import 'package:get/get.dart';

class ChartView extends StatelessWidget {
  const ChartView({super.key});

  @override
  Widget build(BuildContext context) {
    final ChartController controller = Get.put(ChartController());
    final sizeofDevice=MediaQuery.of(context).size.width*0.32;
    late double size=sizeofDevice;
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
            padding: const EdgeInsets.all(10.0),
            child: Container(

              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(10),

              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Current Values",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() {
                          return Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: CustomPaint(
                              painter: ChartPainter(15, controller.data, controller.val.value),
                              size:  Size(size, size),
                              child:  SizedBox.square(
                                dimension: size+50,
                                child:  Center(
                                    child: SizedBox(
                                      width: size*0.90,
                                      height: size*0.35,
                                      child: Column(
                                        children: [
                                          Text(
                                            "₹ 1,250",
                                            style: TextStyle(
                                                fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "Current Values",
                                            style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                          );
                        }),
                        Column(

                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width*0.35,

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromRGBO(0, 0, 0, 0.05)
                              ),
                              child: const Column(
                                children: [
                                  LablesData(lable: 'Clean Price', price: '₹600', lableColor: Colors.blueAccent,),
                                  LablesData(lable: 'Capital Loss', price: '-₹600', lableColor: Colors.red,),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Container(
                              width: MediaQuery.of(context).size.width*0.35,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white30),
                                  borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Column(
                                children: [
                                  LablesData(lable: 'Accured Interest', price: '₹600', lableColor: Colors.yellow,),
                                  LablesData(lable: 'Interest Received', price: '-₹600', lableColor: Colors.orange,),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
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
