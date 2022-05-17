import 'dart:async';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_app/BodyFatCalculator.dart';
import 'package:health_app/LoginScreen.dart';
import 'package:health_app/MentalHealth.dart';
import 'package:health_app/OvulationCounter.dart';
import 'package:health_app/WaterIntake.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:health_app/loading.dart';
import 'package:health_app/login.dart';
import 'package:health_app/provider/sign_in.dart';

import 'BMICalc.dart';
import 'CalorieIntake.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    /*
    return ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Wrapper(),
      ),
    );
    */

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Wrapper(),
    );
  }
}

// wrapper widget for handling login and redirects to pages

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          }

          if (!snapshot.hasData) {
            return const Login();
          }

          return const MainPage();

          /*
              else if (snapshot.hasData) {
                return MainPage();
              }
              else if (snapshot.hasError) {
                return Center(child: Text("Something went wrong!"));
              }
              else {
                return LoginScreen();
              }
               */
        },
      ),
    );
  }
}

// end of wrapper widget

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

  // emoji labels [test]
  var emojis = ['😖', '😟', '🙁', '😕', '😐', '🙂', '😀', '😃', '😄'];

  // timer variables
  late Timer _dayStatePeriodic;
  late Timer _dayStateOneShot;

  // datetime object
  DateTime t = DateTime.now();

  // function to get user name
  void getUserName() {
    setState(() {
      name = user!.displayName!.split(' ')[0];
    });
  }

  // function to determine time-phase of day
  void changeDayState() {
    int hour = t.hour;
    if (hour >= 3 && hour < 12) {
      day_state = "Morning";
    } else if (hour >= 12 && hour < 16) {
      day_state = "Afternoon";
    } else if (hour >= 16 && hour < 22) {
      day_state = "Evening";
    } else {
      day_state = "Night";
    }

    setState(() {});
  }

  @override
  void initState() {
    // start it once at the very beginning [one-shot]
    _dayStateOneShot = Timer(const Duration(seconds: 0), () {
      changeDayState();
      getUserName();
    });
    // periodic timer function call, so that greeting updates as per clock time
    _dayStatePeriodic = Timer.periodic(
        const Duration(seconds: 30), (timer) => changeDayState());

    super.initState();
  }

  @override
  void dispose() {
    _dayStatePeriodic.cancel();
    _dayStateOneShot.cancel();
    super.dispose();
  }

  // getting current user using instance variable
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    // setting up device width and height variables [for responsiveness]
    double scrWidth = MediaQuery.of(context).size.width;
    double scrHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      /*
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

      */

      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter, // changed from topLeft to topCenter
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
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                      )),
                  centerTitle: true,
                ),
                leading: Transform.rotate(
                  angle: 180 * 3.14 / 180,
                  child: IconButton(
                    //icon: const Icon(Icons.menu),
                    icon: const Icon(Icons.logout, size: 28.0),
                    tooltip: "Sign Out",
                    onPressed: () {
                      // here we'll make it call a sidebar modal
                      // but for now it just logs out the user [log-out button substitute]

                      /*
                      final provider = Provider.of<AuthService>(context, listen: false);
                      provider.logOut();
                      */

                      AuthService().logOut();
                    },
                  ),
                ),
                actions: <Widget>[
                  /*
                  IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.add_sharp),
                    tooltip: 'Add new entry',
                    onPressed: () {/* ... */},
                  ),
                  */

                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.transparent,
                    child: CircleAvatar(
                        backgroundImage: NetworkImage(user!.photoURL!)),
                  ),
                ]),
            SliverToBoxAdapter(
              child: ClipPath(
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
                              Text("Hi $name,",
                                  style: const TextStyle(
                                      fontSize: 30, color: Colors.white)),
                              SizedBox(height: scrHeight / 70),
                              Text("Good $day_state, how do you feel?",
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white)),
                              SizedBox(height: scrHeight / 35),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              child: Text(
                                //'🙁',
                                emojis[value.toInt() - 1],
                                style: const TextStyle(fontSize: 25),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                child: SliderTheme(
                                  data: SliderThemeData(
                                    trackHeight: 16,
                                    thumbShape: const RoundSliderThumbShape(
                                        enabledThumbRadius: 12.0),
                                    valueIndicatorTextStyle: const TextStyle(
                                        color: Colors.redAccent),
                                    valueIndicatorColor:
                                        Colors.white.withOpacity(0.94),
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
                                    }),
                                  ),
                                ),
                              ),
                            ),

                            /*
                                  const SizedBox(
                                  child: Text('😃',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  ),
                                   */

                            IconButton(
                              padding: const EdgeInsets.only(right: 5.0),
                              icon: const Icon(Icons.task_alt_rounded,
                                  color: Colors.white),
                              constraints: const BoxConstraints(),
                              onPressed: () async {
                                // writing code to push the values in db

                                DateTime objTime = DateTime.now();

                                String date = objTime.toString().split(' ')[0];
                                String datapoint = objTime.toString() +
                                    "," +
                                    value.toInt().toString();

                                DocumentReference docRef = FirebaseFirestore
                                    .instance
                                    .collection('userData')
                                    .doc(user!.uid);
                                docRef.update({
                                  'date': FieldValue.arrayUnion([date]),
                                  'dtime,points':
                                      FieldValue.arrayUnion([datapoint]),
                                });
                              },
                            )
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
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 2.0), //(x,y)
                                        blurRadius: 20.0,
                                      ),
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.white,
                                        Colors.redAccent
                                            .withBlue(180)
                                            .withGreen(180),
                                      ],
                                    )),
                                child: Column(
                                  children: [
                                    Padding(padding: EdgeInsets.only(top: 10)),
                                    IconButton(
                                      icon: Image.asset(
                                          'assets/icons/body-fat.png'),
                                      iconSize: 80,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const BodyFatCalculator(),
                                          ),
                                        );
                                      },
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "Body Fat",
                                            style: TextStyle(
                                                color: Colors.redAccent
                                                    .withOpacity(1.0),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                              height: 200.0,
                            ),
                            SizedBox(
                              width: 150.0,
                              height: 150.0,
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 2.0), //(x,y)
                                        blurRadius: 20.0,
                                      ),
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.white,
                                        Colors.redAccent
                                            .withBlue(180)
                                            .withGreen(180),
                                      ],
                                    )),
                                child: Column(
                                  children: [
                                    Padding(padding: EdgeInsets.only(top: 10)),
                                    IconButton(
                                      icon: Image.asset('assets/icons/bmi.png'),
                                      iconSize: 80,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const BMICalc(),
                                          ),
                                        );
                                      },
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "BMI Calculator",
                                            style: TextStyle(
                                                color: Colors.redAccent
                                                    .withOpacity(1.0),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
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
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 2.0), //(x,y)
                                        blurRadius: 20.0,
                                      ),
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.white,
                                        Colors.redAccent
                                            .withBlue(180)
                                            .withGreen(180),
                                      ],
                                    )),
                                child: Column(
                                  children: [
                                    Padding(padding: EdgeInsets.only(top: 10)),
                                    IconButton(
                                      icon: Image.asset(
                                          'assets/icons/menstrual-cycle.png'),
                                      iconSize: 80,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const OvulationCounter(),
                                          ),
                                        );
                                      },
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "Ovulation Tracker",
                                            style: TextStyle(
                                                color: Colors.redAccent
                                                    .withOpacity(1.0),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                              height: 200.0,
                            ),
                            SizedBox(
                              width: 150.0,
                              height: 150.0,
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 2.0), //(x,y)
                                        blurRadius: 20.0,
                                      ),
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.white,
                                        Colors.redAccent
                                            .withBlue(180)
                                            .withGreen(180),
                                      ],
                                    )),
                                child: Column(
                                  children: [
                                    Padding(padding: EdgeInsets.only(top: 10)),
                                    IconButton(
                                      icon: Image.asset('assets/icons/water-bottle.png'),
                                      iconSize: 80,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const WaterIntake(),
                                          ),
                                        );
                                      },
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "Water Intake",
                                            style: TextStyle(
                                                color: Colors.redAccent
                                                    .withOpacity(1.0),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
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
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 2.0), //(x,y)
                                        blurRadius: 20.0,
                                      ),
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.white,
                                        Colors.redAccent
                                            .withBlue(180)
                                            .withGreen(180),
                                      ],
                                    )),
                                child: Column(
                                  children: [
                                    Padding(padding: EdgeInsets.only(top: 10)),
                                    IconButton(
                                      icon: Image.asset(
                                          'assets/icons/calories-calculator.png'),
                                      iconSize: 80,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const CalorieIntake(),
                                          ),
                                        );
                                      },
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "Calorie Intake",
                                            style: TextStyle(
                                                color: Colors.redAccent
                                                    .withOpacity(1.0),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                              height: 200.0,
                            ),
                            SizedBox(
                              width: 150.0,
                              height: 150.0,
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 2.0), //(x,y)
                                        blurRadius: 20.0,
                                      ),
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.white,
                                        Colors.redAccent
                                            .withBlue(180)
                                            .withGreen(180),
                                      ],
                                    )),
                                child: Column(
                                  children: [
                                    Padding(padding: EdgeInsets.only(top: 10)),
                                    IconButton(
                                      icon: Image.asset('assets/icons/mental-health.png'),
                                      iconSize: 80,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const HealthGraph(),
                                          ),
                                        );
                                      },
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "Mental Health",
                                            style: TextStyle(
                                                color: Colors.redAccent
                                                    .withOpacity(1.0),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
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

class MyClipper extends CustomClipper<Path> {
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
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
