import 'package:flutter/material.dart';
import 'package:health_app/BodyFatCalculator.dart';
import 'package:health_app/OvulationCounter.dart';

import 'BMICalc.dart';

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

  @override
  Widget build(BuildContext context) {
    // setting up device width and height variables [for responsiveness]
    double scrWidth = MediaQuery.of(context).size.width;
    double scrHeight = MediaQuery.of(context).size.height;

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
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.deepPurpleAccent, // background
                                      onPrimary: Colors.white, // foreground
                                      elevation: 10,
                                    ),
                                    child: const Text('Happy'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.deepPurpleAccent, // background
                                      onPrimary: Colors.white, // foreground
                                      elevation: 10,
                                    ),
                                    child: const Text('Sad'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.deepPurpleAccent, // background
                                      onPrimary: Colors.white, // foreground
                                      elevation: 10,
                                    ),
                                    child: const Text('Angry'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.deepPurpleAccent, // background
                                      onPrimary: Colors.white, // foreground
                                      elevation: 10,
                                    ),
                                    child: const Text('Fatigued'),
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
                                onPressed: () {},
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
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.deepPurpleAccent,
                                  onPrimary: Colors.white,
                                  elevation: 12,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                child: const Text('Pregnancy due date'),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
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
                                child: const Text('Calorie Chart'),
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
                                child: const Text('Meditation Timer'),
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
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.deepPurpleAccent,
                                  onPrimary: Colors.white,
                                  elevation: 12,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                child: const Text('Medical Records'),
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
                                child: const Text('Prescription Record'),
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