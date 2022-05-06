import 'dart:async';

import 'package:flutter/material.dart';
import 'package:health_app/BodyFatCalculator.dart';
import 'package:health_app/OvulationCounter.dart';
import 'package:health_app/WaterIntake.dart';

import 'BMICalc.dart';
import 'CalorieIntake.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final bool _pinned = true;
  final bool _snap = false;
  final bool _floating = false;

  // variables added by Abhinandan
  String name = "John";
  String day_state = "Morning";

  // vars for slider with emotion scale [1-9]
  double value = 5;
  var labels = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];


  // datetime object
  DateTime t = DateTime.now();


  @override
  Widget build(BuildContext context) {
    // setting up device width and height variables [for responsiveness]
    double scrWidth = MediaQuery.of(context).size.width;
    double scrHeight = MediaQuery.of(context).size.height;

    // function to determine time-phase of day
    void changeDayState()
    {
      int hour = t.hour;
      if (hour >= 3 && hour < 12) {
        day_state = "Morning";
      }

      else if (hour >= 12 && hour < 16) {
        day_state = "Afternoon";
      }

      else if (hour >= 16 && hour < 22) {
        day_state = "Evening";
      }

      else
      {
        day_state = "Night";
      }

      setState(() {});

    }

    // start it once at the very beginning [one-shot]
    Timer(Duration(seconds: 1), () => changeDayState());

    // periodic timer function call, so that greeting updates as per clock time
    Timer.periodic(Duration(seconds: 30), (timer) => changeDayState());

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.account_circle)),
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.home)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,     // changed from topLeft to topCenter
          end: Alignment.bottomLeft,
          colors: [
            Colors.redAccent,
            Colors.white,
          ],
        )),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
                shape: const ContinuousRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(90),
                        bottomRight: Radius.circular(90))),
                pinned: _pinned,
                snap: _snap,
                floating: _floating,
                expandedHeight: 150.0,
                backgroundColor: Colors.black.withOpacity(0.15),
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text('HealUp',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )),
                  centerTitle: true,
                ),
                actions: <Widget>[
                  IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.add_sharp),
                    tooltip: 'Add new entry',
                    onPressed: () {/* ... */},
                  ),
                ]),
            SliverToBoxAdapter(
              child:
                  ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.redAccent.withOpacity(0.15),
                            Colors.redAccent.withOpacity(0.4),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                        horizontal: scrWidth / 40, vertical: scrHeight / 14),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0, right: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Hi $name",
                                        style: const TextStyle(fontSize: 30, color: Colors.white)),
                                    SizedBox(height: scrHeight / 70),
                                    Text("Good $day_state, how do you feel?",
                                        style: const TextStyle(fontSize: 20, color: Colors.white)),
                                    SizedBox(height: scrHeight / 35),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  const SizedBox(
                                    child: Text('🙁',
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      child: SliderTheme(
                                        data: SliderThemeData(
                                          trackHeight: 16,
                                          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                                          valueIndicatorTextStyle: TextStyle(color: Colors.redAccent),
                                          valueIndicatorColor: Colors.white.withOpacity(0.94),
                                        ),
                                        child: Slider(
                                          value: value,
                                          min: 1.0,
                                          max: 9.0,
                                          divisions: 8,
                                          label: labels[value.toInt() - 1],
                                          activeColor: Colors.redAccent.shade200,
                                          inactiveColor: Colors.white38,
                                          //label: value.round().toString(),
                                          onChanged: (double value) => setState(() {
                                            this.value = value;
                                            print(value);
                                          }
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                  child: Text('😃',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                            ],
                        ),
                      ),
                    ),
                  ),

              // end of code
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: scrWidth / 25, vertical: scrHeight / 14),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 150.0,
                              height: 150.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const BodyFatCalculator(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  //primary: Colors.white10.withOpacity(0),
                                  //onPrimary: Colors.white,
                                  primary: Colors.deepPurpleAccent,
                                  onPrimary: Colors.white,
                                  elevation: 12,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                child: const Text('Body Fat'),
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                              height: 200.0,
                            ),
                            SizedBox(
                              width: 150.0,
                              height: 150.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const BMICalc(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.deepPurpleAccent,
                                  onPrimary: Colors.white,
                                  elevation: 12,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                child: const Text('BMI Calculator'),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 150.0,
                              height: 150.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const OvulationCounter(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.deepPurpleAccent,
                                  onPrimary: Colors.white,
                                  elevation: 12,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                child: const Text('Ovulation Tracker'),
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                              height: 200.0,
                            ),
                            SizedBox(
                              width: 150.0,
                              height: 150.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const WaterIntake(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.deepPurpleAccent,
                                  onPrimary: Colors.white,
                                  elevation: 12,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                child: const Text('Water Intake'),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 150.0,
                              height: 150.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const CalorieIntake(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.deepPurpleAccent,
                                  onPrimary: Colors.white,
                                  elevation: 12,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                child: const Text('Calorie Intake'),
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                              height: 200.0,
                            ),
                            SizedBox(
                              width: 150.0,
                              height: 150.0,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.deepPurpleAccent,
                                  onPrimary: Colors.white,
                                  elevation: 12,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                child: const Text('Mental Health Record'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path>
{
  @override
  Path getClip(Size size) {
    var path = Path();

    double x = size.width;
    double y = size.height;

    path.lineTo(0.0, y);

    var firstControlPoint = Offset(x / 6, y - (y / 8));
    var firstEndPoint = Offset(x / 2, y - (y / 16));
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(x - (x / 6), y);
    var secondEndPoint = Offset(x, y - (y / 7));
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(x, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper)
  {
    return true;
  }
}