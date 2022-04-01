import 'dart:math';

import 'package:flutter/material.dart';

class BMICalc extends StatefulWidget {
  const BMICalc({Key? key}) : super(key: key);

  @override
  State<BMICalc> createState() => _BMICalcState();
}

class _BMICalcState extends State<BMICalc> {

  // variable for custom radio button
  int currentindex = 0;
  String result = "";
  String classify = "";
  double height = 0;
  double weight = 0;

  // declaring inputController to get input values
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(180),
          child: AppBar(
            elevation: 7,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))),
            backgroundColor: Color.fromRGBO(255, 255, 255, 1),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.settings, color: Colors.black)
              )
            ],
            flexibleSpace: const FlexibleSpaceBar(
              title: Text("BMI Calculator",
                  style: TextStyle(color: Colors.redAccent, fontSize: 28)),
              centerTitle: true,
              titlePadding: EdgeInsets.symmetric(vertical: 60.0),
            ),
          ),
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: 30.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Height (in cm): ", style: TextStyle(fontSize: 18.0)),
                    Text("Weight (in Kg): ", style: TextStyle(fontSize: 18.0)),
                  ],
                ),

                SizedBox(
                  height: 20.0,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 130,
                      child: TextField(
                        controller: heightController,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: "eg., 170",
                            hintStyle: TextStyle(fontStyle: FontStyle.italic),
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            )

                        ),
                      ),
                    ),

                    Container(
                      width: 130,
                      child: TextField(
                        controller: weightController,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: "eg., 60",
                            hintStyle: TextStyle(fontStyle: FontStyle.italic),
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            )

                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 50.0),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 35),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                    height: 60.0,
                    onPressed: () {
                      height = double.parse(heightController.value.text);
                      weight = double.parse(weightController.value.text);
                      calculateBMI(height, weight);
                    },
                    child: Text(
                      "Calculate BMI",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    color: Colors.redAccent.withOpacity(0.8),
                  ),
                ),

                SizedBox(height: 50.0),

                Container(
                    width: double.infinity,
                    child: Text(
                        "$result",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        )
                    )
                ),

                SizedBox(height: 30.0),

                Container(
                    width: double.infinity,
                    child: Text(
                        "$classify",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.redAccent,
                        )
                    )
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  void calculateBMI(double height, double weight)
  {
    double finalresult = weight / pow(height / 100, 2);
    String bmi = finalresult.toStringAsFixed(2);
    String cat = "";

    if (finalresult < 18.5)
      cat = "Underweight";
    else if (finalresult >= 18.5 && finalresult < 25.0)
      cat = "Normal Weight";
    else if (finalresult >= 25.0 && finalresult < 30.0)
      cat = "Pre-Obesity";
    else if (finalresult >= 30.0 && finalresult < 35.0)
      cat = "Obesity Class I";
    else if (finalresult >= 35.0 && finalresult < 40.0)
      cat = "Obesity Class II";
    else if (finalresult >= 40.0)
      cat = "Obesity Class III";


    setState(() {
      result = bmi;
      classify = cat;
    });
  }
}
