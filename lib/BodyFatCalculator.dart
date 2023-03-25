import 'package:flutter/material.dart';
import 'dart:math';


class BodyFatCalculator extends StatefulWidget {
  const BodyFatCalculator({Key? key}) : super(key: key);

  @override
  State<BodyFatCalculator> createState() => _BodyFatCalculatorState();
}

class _BodyFatCalculatorState extends State<BodyFatCalculator> {

  int currentindex = 0;
  bool hipIsVisible = false;

  double height = 0;
  double neck = 0;
  double waist = 0;
  double hip = 0;

  // result variable
  double bfp = 0;
  String remark = "";

  // declaring inputController to get input values
  TextEditingController heightInput = TextEditingController();
  TextEditingController neckInput = TextEditingController();
  TextEditingController waistInput = TextEditingController();
  TextEditingController hipInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            elevation: 7,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))),
            backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
            actions: const [],
            flexibleSpace: const FlexibleSpaceBar(
              title: Text("Body Fat Calculator",
                  style: TextStyle(color: Colors.redAccent, fontSize: 28)),
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
                    currentindex == 0 ? Colors.blueAccent.withOpacity(0.1) : Colors.redAccent.withOpacity(0.1),
                    currentindex == 0 ? Colors.blueAccent.withOpacity(0.5) : Colors.redAccent.withOpacity(0.5),
                  ]
              )
          ),
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
                      Flexible(
                        flex: 3,
                        child: Container(
                          //color: Colors.red,
                            child: const Text(
                                "Height\n(in cm) ",
                                style: TextStyle(fontSize: 18.0)
                            )
                        ),
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
                                hintStyle: const TextStyle(fontStyle: FontStyle.italic),
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none,
                                )

                            ),
                          ),
                        ),
                      ),
                    ],
                  ),


                  // neck
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 3,
                        child: Container(
                          //color: Colors.red,
                            child: const Text(
                                "Neck\n(in cm)",
                                style: TextStyle(fontSize: 18.0)
                            )
                        ),
                      ),

                      const Spacer(flex: 1),

                      Flexible(
                        flex: 5,
                        child: SizedBox(
                          width: 180,
                          child: TextField(
                            controller: neckInput,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: "eg., 50",
                                hintStyle: const TextStyle(fontStyle: FontStyle.italic),
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none,
                                )

                            ),
                          ),
                        ),
                      ),
                    ],
                  ),


                  // waist
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 3,
                        child: Container(
                          //color: Colors.red,
                            child: const Text(
                                "Waist\n(in cm)",
                                style: TextStyle(fontSize: 18.0)
                            )
                        ),
                      ),

                      const Spacer(flex: 1),

                      Flexible(
                        flex: 5,
                        child: SizedBox(
                          width: 180,
                          child: TextField(
                            controller: waistInput,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: "eg., 96",
                                hintStyle: const TextStyle(fontStyle: FontStyle.italic),
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none,
                                )

                            ),
                          ),
                        ),
                      ),
                    ],
                  ),


                  // hip [if female]

                  Visibility(
                    visible: hipIsVisible,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 3,
                            child: Container(
                              //color: Colors.red,
                                child: const Text(
                                    "Hip\n(in cm)",
                                    style: TextStyle(fontSize: 18.0)
                                )
                            ),
                          ),

                          const Spacer(flex: 1),

                          Flexible(
                            flex: 5,
                            child: SizedBox(
                              width: 180,
                              child: TextField(
                                controller: hipInput,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: "eg., 92",
                                    hintStyle: const TextStyle(fontStyle: FontStyle.italic),
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide.none,
                                    )

                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 50.0),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child:   MaterialButton(
                      onPressed: () {

                        height = double.parse(heightInput.value.text);
                        waist = double.parse(waistInput.value.text);
                        neck = double.parse(neckInput.value.text);
                        if (currentindex == 1) {
                          hip = double.parse(hipInput.value.text);
                        }
                        else {
                          hip = 0;
                        }

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BodyFatResults(index: currentindex, height: height, waist: waist, neck: neck, hip: hip))
                        );
                      },                      height: 60.0,
                      padding: EdgeInsets.all(0),
                      child: const Text(
                        "Calculate Body Fat",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      color: currentindex == 0 ? Colors.lightBlueAccent : Colors.redAccent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                    ),

                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void changeIndex(int index)
  {
    setState(() {
      currentindex = index;

      if (currentindex == 1) {
        hipIsVisible = true;
      }
      else {
        hipIsVisible = false;
      }
    });
  }

  // creating custom radio widget
  Widget radioButton(String value, Color color, int index)
  {
    return Expanded(
        child: Container(

          margin: const EdgeInsets.symmetric(horizontal: 12.0),
          height: 60.0,

          child: MaterialButton(
            // color of button needs to change in function if it is selected [or otherwise]
            // if button = pressed -> currentindex = index of button, so we will assign a custom color
            // else, it will be grey
            color: currentindex == index ? color: Colors.grey[200],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            onPressed: (){
              changeIndex(index);
            },

            child: Text(value, style: TextStyle(
              color: currentindex == index ? Colors.white : color,
              fontSize: 18,
            )),

          ),
        )
    );
  }
}

class BodyFatResults extends StatefulWidget {

  final double height;
  final double neck;
  final double waist;
  final double hip;
  final int index;

  const BodyFatResults({Key? key, required this.index, required this.height, required this.neck, required this.waist, required this.hip}) : super(key: key);

  @override
  State<BodyFatResults> createState() => _BodyFatResultsState();
}

class _BodyFatResultsState extends State<BodyFatResults> {

  // res-vars
  double bfp = 0;
  String remark = "";
  String suggest = "";


  // hip calc essential functions here...

  double logby10(double exp)
  {
    return (log(exp) / ln10);
  }

  double calcBFP_male(double waist, double neck, double height)
  {
    double bfpDenom = 1.0324 - 0.19077 * logby10(waist-neck) + 0.15456 * logby10(height);
    double finalBfp = 495 / bfpDenom - 450;
    return finalBfp;
  }

  double calcBFP_female(double waist, double neck, double height, double hip)
  {
    double bfpDenom = 1.29579 - 0.35004 * logby10(waist+hip-neck) + 0.22100 * logby10(height);
    double finalBfp = 495 / bfpDenom - 450;
    return finalBfp;
  }

  String male_classify(double bfp)
  {

    bfp = bfp.ceilToDouble();

    if (bfp >=2 && bfp <=5)
    {
      return("Essential Fat");
    }

    else if (bfp >=6 && bfp <=13)
    {
      return("Atheletes");
    }

    else if (bfp >=14 && bfp <=17)
    {
      return("Fitness");
    }

    else if (bfp >=18 && bfp <=24)
    {
      return("Average");
    }

    else if (bfp >=25)
    {
      return("Obese");
    }

    else
    {
      return("Invalid");
    }
  }

  String female_classify(double bfp)
  {

    bfp = bfp.ceilToDouble();

    if (bfp >=10 && bfp <=13)
    {
      return("Essential Fat");
    }

    else if (bfp >=14 && bfp <=20)
    {
      return("Atheletes");
    }

    else if (bfp >=21 && bfp <=24)
    {
      return("Fitness");
    }

    else if (bfp >=25 && bfp <=31)
    {
      return("Average");
    }

    else if (bfp >=32)
    {
      return("Obese");
    }

    else
    {
      return("Invalid");
    }
  }

  String suggestionFunc(String remark)
  {
    if (remark == "Essential Fat")
    {
      return("You might want to gain some weight");
    }

    else if (remark == "Atheletes")
    {
      return("You have an athletic body structure\nHowever, you might want to gain some fat.");
    }

    else if (remark == "Fitness")
    {
      return("You have perfect amount of fat in body\nKeep your body toned with regular workouts");
    }

    else if (remark == "Average")
    {
      return("Your body fat percentage is similar to that of an average person\n\nYou might want to work out a bit..");
    }

    else if (remark == "Obese")
    {
      return("We recommend you to start taking care of your health\nDon't hesitate.. start today");
    }

    else
    {
      return ("Invalid data entered");
    }
  }

  void calculateAll()
  {
    setState(() {
      if (widget.index == 0)
      {
        bfp = calcBFP_male(widget.waist, widget.neck, widget.height);
        remark = male_classify(bfp);
        suggest = suggestionFunc(remark);
      }

      else if (widget.index == 1)
      {
        bfp = calcBFP_female(widget.waist, widget.neck, widget.height, widget.hip);
        remark = female_classify(bfp);
        suggest = suggestionFunc(remark);
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
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.black.withOpacity(0.85),
                      Colors.black.withOpacity(0.9),
                    ]
                )
            ),
            child: CustomScrollView(
                slivers: [
                  const SliverAppBar(

                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        )
                    ),

                    pinned: true,
                    snap: false,
                    floating: false,
                    forceElevated: true,
                    elevation: 10,
                    foregroundColor: Colors.black,
                    expandedHeight: 120,
                    backgroundColor: Colors.white,
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: EdgeInsets.only(bottom: 35),
                      centerTitle: true,
                      title: Text("Results",
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
                        Stack(
                            clipBehavior: Clip.none, children: [
                              Positioned(
                                top: 240,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                                    color: widget.index == 0 ? Colors.blueAccent.withOpacity(0.8) : Colors.redAccent.withOpacity(0.8),
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0, bottom: 30.0),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 40.0),
                                        const Text("Category: ", style: TextStyle(fontSize: 20, color: Colors.white)),
                                        const SizedBox(height: 15.0),
                                        RichText(
                                            text: TextSpan(
                                                style: const TextStyle(color: Colors.white),
                                                children: [
                                                  TextSpan(text:remark, style: const TextStyle(fontSize: 48)),
                                                ]
                                            )
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              Positioned(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                                    color: Colors.white,
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 30.0),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 40.0),
                                        const Text("Body Fat Percentage: ", style: TextStyle(fontSize: 20)),
                                        const SizedBox(height: 15.0),
                                        RichText(
                                            text: TextSpan(
                                                style: const TextStyle(color: Colors.black),
                                                children: [
                                                  TextSpan(text:bfp.toStringAsFixed(2), style: const TextStyle(fontSize: 102)),
                                                  const TextSpan(text:" %", style: TextStyle(fontSize: 48)),
                                                ]
                                            )
                                        ),
                                        const SizedBox(height: 20.0),
                                        const Text("** calculated using US-Navy Body Fat Formula", style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                        const SizedBox(height: 190),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              const Text("Suggestion: ", style: TextStyle(fontSize: 26, color: Colors.white)),
                              const SizedBox(height: 25.0),
                              Text(suggest, style: const TextStyle(fontSize: 18, color: Colors.white, fontStyle: FontStyle.italic), textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      ],

                    ),
                  ),
                ]
            )
        )
    );
  }
}
