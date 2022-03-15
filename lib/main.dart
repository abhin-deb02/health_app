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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              pinned: _pinned,
              snap: _snap,
              floating: _floating,
              expandedHeight: 140.0,
              backgroundColor: Colors.white70,
              flexibleSpace: const FlexibleSpaceBar(
                title: Text('HealUp',
                    style: TextStyle(fontSize: 30, color: Colors.blue)),
                centerTitle: true,
              ),
              actions: <Widget>[
                IconButton(
                  color: Colors.blue,
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
                          child: Text('Happy'),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Sad'),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Angry'),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Fatigued'),
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
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 175.0,
                          height: 175.0,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text('Ideal Weight'),
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
                            child: Text('Body Fat'),
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
                            child: Text('Medical Records'),
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
                            child: Text('Water Intake'),
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
                            child: Text('Mental Health Record'),
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
                            child: const Text('Prescription Record'),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
