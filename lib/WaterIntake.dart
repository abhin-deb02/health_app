import 'dart:math';

import 'package:flutter/material.dart';

class WaterIntake extends StatefulWidget {
  const WaterIntake({Key? key}) : super(key: key);

  @override
  State<WaterIntake> createState() => _WaterIntakeState();
}

class _WaterIntakeState extends State<WaterIntake> {
  // variable for custom radio button
  String result = "";
  double workOut = 0;
  double weight = 0;

  // declaring inputController to get input values
  TextEditingController workOutController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180),
        child: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 7,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.settings, color: Colors.black))
          ],
          flexibleSpace: const FlexibleSpaceBar(
            title: Text("Water Intake Calculator",
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
              const SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text("Workout (in Hours): ",
                      style: TextStyle(fontSize: 15.0)),
                  Text("Weight (in Kg): ", style: TextStyle(fontSize: 15.0)),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 130,
                    child: TextField(
                      controller: workOutController,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "eg., 1.5",
                          hintStyle:
                              const TextStyle(fontStyle: FontStyle.italic),
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 130,
                    child: TextField(
                      controller: weightController,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "eg., 60",
                          hintStyle: const TextStyle(fontStyle: FontStyle.italic),
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          )),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50.0),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  height: 60.0,
                  onPressed: () {
                    workOut = double.parse(workOutController.value.text);
                    weight = double.parse(weightController.value.text);
                    waterIntakeCalc(workOut, weight);
                  },
                  child: const Text(
                    "Calculate Water Intake",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  color: Colors.redAccent.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 50.0),
              SizedBox(
                  width: double.infinity,
                  child: Text("$result Litres",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ))),
              const SizedBox(height: 30.0),
              const SizedBox(
                  width: double.infinity,
                  child: Text("Is all you need for the day!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.redAccent,
                      ))),
            ],
          ),
        ),
      ),
    );
  }

  void waterIntakeCalc(double height, double weight) {
    double finalResult = workOut + 0.35 + height / 30;
    String intake = finalResult.toStringAsFixed(2);

    setState(() {
      result = intake;
    });
  }
}
