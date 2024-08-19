import 'package:flutter/material.dart';
import 'package:circularchart/sectioned_piechart/chart_painter.dart';
import 'package:get/get.dart';

///Example of required data

///  var data = <PieChartData>[
///    PieChartData(Colors.orangeAccent, 20.0, 0.0, Colors.orangeAccent,
///        Colors.orangeAccent, false),
///     PieChartData(Colors.deepOrange, 10.0, 0.0, Colors.deepOrange,
///         Colors.deepOrange, false),
///    PieChartData(Colors.blueAccent, 70.0, 0.0, Colors.green, Colors.red, true),
///   ].obs;

class ChartView extends StatelessWidget {
  final RxList<PieChartData> data;
  final int currentValues;
  final int cleanPrice;
  final int capitalLP;
  final bool isCapitalLoss;
  final int accruedInterest;
  final int interestReceived;

  const ChartView(
      {super.key,
      required this.data,
      required this.currentValues,
      required this.cleanPrice,
      required this.capitalLP,
      required this.isCapitalLoss,
      required this.accruedInterest,
      required this.interestReceived});

  void updateFill(int index, double value) {
    if (index >= 0 && index < data.length) {
      data[index].fillValue.value = value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeofDevice = MediaQuery.of(context).size.width * 0.32;
    late double size = sizeofDevice;
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Current Values",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() {
                          return Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: CustomPaint(
                              painter: ChartPainter(15, data),
                              size: Size(size, size),
                              child: SizedBox.square(
                                dimension: size + 50,
                                child: Center(
                                    child: SizedBox(
                                  width: size * 0.90,
                                  height: size * 0.35,
                                  child: Column(
                                    children: [
                                      Text(
                                        "\u{20B9} ${currentValues.toString()}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Text(
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
                              width: MediaQuery.of(context).size.width * 0.35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromRGBO(0, 0, 0, 0.05)),
                              child: Column(
                                children: [
                                  LablesData(
                                    lable: 'Clean Price',
                                    price: cleanPrice.toString(),
                                    lableColor: Colors.blueAccent,
                                    isCapital: false,
                                    isLoss: false,
                                  ),
                                  LablesData(
                                    lable:
                                        'Capital ${isCapitalLoss ? "loss" : "gain"}',
                                    price: capitalLP.toString(),
                                    lableColor: isCapitalLoss
                                        ? Colors.red
                                        : Colors.green,
                                    isCapital: true,
                                    isLoss: isCapitalLoss,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white30),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  LablesData(
                                    lable: 'Accrued Interest',
                                    price: accruedInterest.toString(),
                                    lableColor: Colors.yellow,
                                    isCapital: false,
                                    isLoss: false,
                                  ),
                                  LablesData(
                                    lable: 'Interest Received',
                                    price: interestReceived.toString(),
                                    lableColor: Colors.orange,
                                    isCapital: false,
                                    isLoss: false,
                                  ),
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
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}

class LablesData extends StatelessWidget {
  final String lable;
  final String price;
  final Color lableColor;
  final bool isCapital;
  final bool isLoss;

  const LablesData(
      {super.key,
      required this.lable,
      required this.price,
      required this.lableColor,
      required this.isCapital,
      required this.isLoss});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 10,
                height: 10,
                color: lableColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                lable,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              isCapital
                  ? Text(
                      "${isLoss ? "-" : ""}\u{20B9} $price",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: isLoss ? Colors.red : Colors.green),
                    )
                  : Text(
                      "\u{20B9} $price",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.black),
                    ),
            ],
          )
        ],
      ),
    );
  }
}

class PieChartData {
  PieChartData(this.color, double percent, double fillValue, Color pbColor,
      Color sbColor, bool isSecondary)
      : percent = percent.obs,
        fillValue = fillValue.obs,
        pbColor = pbColor.obs,
        sbColor = sbColor.obs,
        isSecondary = isSecondary.obs;

  final Color color;
  final RxDouble percent;
  final RxDouble fillValue;
  final Rx<Color> pbColor;
  final Rx<Color> sbColor;
  final RxBool isSecondary;
}
