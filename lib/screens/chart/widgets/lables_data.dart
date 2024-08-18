import 'package:flutter/material.dart';

class LablesData extends StatelessWidget {
  final String lable;
  final String price;
  final Color lableColor;
  const LablesData({super.key,required this.lable,required this.price,required this.lableColor});


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
              SizedBox(width: 10,),
              Text(lable,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.black54),)

            ],
          ),
          Column(
            crossAxisAlignment:CrossAxisAlignment.end ,
            children: [
              Text(price,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),

            ],
          )


        ],
      ),
    );
  }
}
