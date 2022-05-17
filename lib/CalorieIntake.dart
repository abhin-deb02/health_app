import 'package:flutter/material.dart';
import 'dart:math';

class CalorieIntake extends StatefulWidget {
  const CalorieIntake({Key? key}) : super(key: key);

  @override
  State<CalorieIntake> createState() => _CalorieIntakeState();
}

class _CalorieIntakeState extends State<CalorieIntake> {
  int currentindex = 0;

  double height = 0;
  double age = 0;
  double weight = 0;

  // result variable
  double bodyFatPercentage = 0;

  // declaring inputController to get input values
  TextEditingController heightInput = TextEditingController();
  TextEditingController weightInput = TextEditingController();
  TextEditingController ageInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 7,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
          actions: const [],
          flexibleSpace: const FlexibleSpaceBar(
            title: Text("Calorie Intake Calculator",
                style: TextStyle(color: Colors.redAccent, fontSize: 24)),
            centerTitle: true,
            titlePadding: EdgeInsets.symmetric(vertical: 30.0),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              currentindex == 0
                  ? Colors.blueAccent.withOpacity(0.1)
                  : Colors.redAccent.withOpacity(0.1),
              currentindex == 0
                  ? Colors.blueAccent.withOpacity(0.5)
                  : Colors.redAccent.withOpacity(0.5),
            ])),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10.0),

                Row(
                  children: [
                    radioButton("Male", Colors.lightBlueAccent, 0),
                    radioButton("Female", Colors.redAccent, 1),
                  ],
                ),

                // height
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Flexible(
                      flex: 3,
                      child: Text("Height\n(in cm) ",
                          style: TextStyle(fontSize: 18.0)),
                    ),
                    const Spacer(flex: 1),
                    Flexible(
                      flex: 5,
                      child: SizedBox(
                        width: 180,
                        child: TextField(
                          controller: heightInput,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "eg., 178",
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
                    ),
                  ],
                ),

                const SizedBox(height: 20.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Flexible(
                      flex: 3,
                      child: Text("Weight\n(in kg) ",
                          style: TextStyle(fontSize: 18.0)),
                    ),
                    const Spacer(flex: 1),
                    Flexible(
                      flex: 5,
                      child: SizedBox(
                        width: 180,
                        child: TextField(
                          controller: weightInput,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "eg., 67",
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
                    ),
                  ],
                ),

                const SizedBox(height: 20.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Flexible(
                      flex: 3,
                      child: Text("Age\n(years)",
                          style: TextStyle(fontSize: 18.0)),
                    ),
                    const Spacer(flex: 1),
                    Flexible(
                      flex: 5,
                      child: SizedBox(
                        width: 180,
                        child: TextField(
                          controller: ageInput,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "eg., 20",
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
                      height = double.parse(heightInput.value.text);
                      weight = double.parse(weightInput.value.text);
                      age = double.parse(ageInput.value.text);

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BodyFatResults(
                              index: currentindex,
                              height: height,
                              weight: weight,
                              age: age)));
                    },
                    child: const Text(
                      "Calculate Calorie Intake",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    color: currentindex == 0
                        ? Colors.lightBlueAccent
                        : Colors.redAccent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void changeIndex(int index) {
    setState(() {
      currentindex = index;
    });
  }

  // creating custom radio widget
  Widget radioButton(String value, Color color, int index) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      height: 60.0,
      child: FlatButton(
        // color of button needs to change in function if it is selected [or otherwise]
        // if button = pressed -> currentindex = index of button, so we will assign a custom color
        // else, it will be grey
        color: currentindex == index ? color : Colors.grey[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        onPressed: () {
          changeIndex(index);
        },

        child: Text(value,
            style: TextStyle(
              color: currentindex == index ? Colors.white : color,
              fontSize: 18,
            )),
      ),
    ));
  }
}

class BodyFatResults extends StatefulWidget {
  final double height;
  final double weight;
  final double age;
  final int index;

  const BodyFatResults({
    Key? key,
    required this.index,
    required this.height,
    required this.weight,
    required this.age,
  }) : super(key: key);

  @override
  State<BodyFatResults> createState() => _BodyFatResultsState();
}

class _BodyFatResultsState extends State<BodyFatResults> {
  // res-vars
  double CalorieIntake = 0;
  String remark = "";
  String suggest = "";

  // hip calc essential functions here...

  double calcCalorieMale(double age, double height, weight) {
    double calorieMale =
        (13.397 * weight + 4.799 * height - 5.677 * age + 88.362) * 1.2;
    return calorieMale;
  }

  double calcCalorieFemale(double age, double height, weight) {
    double calorieFemale =
        (9.247 * weight + 3.098 * height - 4.330 * age + 447.593) * 1.2;

    return calorieFemale;
  }

  void calculateAll() {
    setState(() {
      if (widget.index == 0) {
        CalorieIntake =
            calcCalorieMale(widget.age, widget.height, widget.weight);
      } else if (widget.index == 1) {
        CalorieIntake =
            calcCalorieFemale(widget.age, widget.height, widget.weight);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    calculateAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    stops: [
                  0.3,
                  1.0
                ],
                    colors: [
                  (widget.index == 1)
                      ? Colors.redAccent.withOpacity(0.85)
                      : Colors.blue.withOpacity(0.9),
                  (widget.index == 1)
                      ? Colors.black87.withOpacity(0.9)
                      : Colors.black.withOpacity(0.9),
                ])),
            child: CustomScrollView(slivers: [
              const SliverAppBar(
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )),
                pinned: true,
                snap: false,
                floating: false,
                forceElevated: true,
                iconTheme: IconThemeData(color: Colors.black),
                elevation: 10,
                foregroundColor: Colors.white,
                expandedHeight: 120,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(bottom: 35),
                  centerTitle: true,
                  title: Text(
                    "Results",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Stack(clipBehavior: Clip.none, children: [
                      Positioned(
                        top: 240,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30)),
                            color: widget.index == 0
                                ? Colors.blueAccent.withOpacity(0.8)
                                : Colors.redAccent.withOpacity(0.8),
                          ),
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      Positioned(
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30)),
                            color: Colors.white,
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: Column(
                              children: [
                                const SizedBox(height: 40.0),
                                const Text("Calories needed: ",
                                    style: TextStyle(fontSize: 40)),
                                const SizedBox(height: 35.0),
                                const Text("For maintaining weight: ",
                                    style: TextStyle(fontSize: 25)),
                                const SizedBox(height: 15.0),
                                RichText(
                                    text: TextSpan(
                                        style: const TextStyle(
                                            color: Colors.black),
                                        children: [
                                      TextSpan(
                                          text:
                                              CalorieIntake.toStringAsFixed(2),
                                          style: const TextStyle(fontSize: 25)),
                                    ])),
                                const SizedBox(height: 15.0),
                                const Text("Mild weight loss: ",
                                    style: TextStyle(fontSize: 25)),
                                const SizedBox(height: 15.0),
                                RichText(
                                    text: TextSpan(
                                        style: const TextStyle(
                                            color: Colors.black),
                                        children: [
                                      TextSpan(
                                          text: (CalorieIntake * 91 / 100)
                                              .toStringAsFixed(2),
                                          style: const TextStyle(fontSize: 25)),
                                    ])),
                                const SizedBox(height: 15.0),
                                const Text("Extreme weight loss: ",
                                    style: TextStyle(fontSize: 25)),
                                const SizedBox(height: 15.0),
                                RichText(
                                    text: TextSpan(
                                        style: const TextStyle(
                                            color: Colors.black),
                                        children: [
                                      TextSpan(
                                          text: (CalorieIntake * 81 / 100)
                                              .toStringAsFixed(2),
                                          style: const TextStyle(fontSize: 25)),
                                    ])),
                                const SizedBox(height: 20.0),
                                const Text(
                                    "** calculated using Harris-Benedict Formula",
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 15)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
                    const SizedBox(height: 190),
                  ],
                ),
              ),
            ])));
  }
}
