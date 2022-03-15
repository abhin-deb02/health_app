import 'package:flutter/material.dart';

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
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

  // variables added by Abhinandan
  String name = "John";
  String day_state = "Morning";

  @override
  Widget build(BuildContext context) {
    // setting up device width and height variables [for responsiveness]
    double scr_width = MediaQuery.of(context).size.width;
    double scr_height = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.blue,
          Colors.red,
        ],
      )),
      child: Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        bottomNavigationBar: BottomAppBar(
          color: Colors.white30,
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
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.lightBlueAccent,
              Colors.deepPurple,
            ],
          )),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                  shape: const ContinuousRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(120), bottomRight: Radius.circular(120))),
                  pinned: _pinned,
                  snap: _snap,
                  floating: _floating,
                  expandedHeight: 180.0,
                  backgroundColor: Colors.white38,
                  flexibleSpace: const FlexibleSpaceBar(
                    title: Text('HealUp',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        )),
                    centerTitle: true,
                  ),
                  actions: <Widget>[
                    IconButton(
                      color: Colors.white70,
                      icon: const Icon(Icons.add_sharp),
                      tooltip: 'Add new entry',
                      onPressed: () {/* ... */},
                    ),
                  ]),
              SliverToBoxAdapter(
                child:
                    //child: Text('Your Favourite health recorder!'),

                    // code snippet from Abhinandan

                    Container(
                  //color: Colors.white30,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Hi $name", style: TextStyle(fontSize: 28)),
                              SizedBox(height: 10),
                              Text("Good $day_state, how do you feel?",
                                  style: TextStyle(fontSize: 20)),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text('Happy'),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text('Sad'),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text('Angry'),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text('Fatigued'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

                // end of code
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.black12,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 175.0,
                                height: 175.0,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  child: const Text('Ideal Weight'),
                                ),
                              ),
                              const SizedBox(
                                width: 20.0,
                                height: 250.0,
                              ),
                              SizedBox(
                                width: 175.0,
                                height: 175.0,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  child: const Text('Body Fat'),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 175.0,
                                height: 175.0,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  child: const Text('Medical Records'),
                                ),
                              ),
                              const SizedBox(
                                width: 20.0,
                                height: 250.0,
                              ),
                              SizedBox(
                                width: 175.0,
                                height: 175.0,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
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
                                width: 175.0,
                                height: 175.0,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  child: const Text('Pregnancy due date'),
                                ),
                              ),
                              const SizedBox(
                                width: 20.0,
                                height: 250.0,
                              ),
                              SizedBox(
                                width: 175.0,
                                height: 175.0,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
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
                                width: 175.0,
                                height: 175.0,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  child: const Text('Calorie Chart'),
                                ),
                              ),
                              const SizedBox(
                                width: 20.0,
                                height: 250.0,
                              ),
                              SizedBox(
                                width: 175.0,
                                height: 175.0,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
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
                                width: 175.0,
                                height: 175.0,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  child: const Text('BMI Calculator'),
                                ),
                              ),
                              const SizedBox(
                                width: 20.0,
                                height: 250.0,
                              ),
                              SizedBox(
                                width: 175.0,
                                height: 175.0,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
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
      ),
    );
  }
}
