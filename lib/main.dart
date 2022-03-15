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
        color: Colors.white12,
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
            backgroundColor: Colors.white12,

            flexibleSpace: const FlexibleSpaceBar(
              title: Text('HealUp', style: TextStyle(fontSize: 30, color: Colors.red)),
                centerTitle: true,
            ),
          ),
          SliverToBoxAdapter(
            child:
                //child: Text('Your Favourite health recorder!'),

                // code snippet from Abhinandan

                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
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
                              Text("Good $day_state, how do you feel?", style: TextStyle(fontSize: 20)),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RaisedButton(child: Text("Happy"), onPressed: () {}, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                            SizedBox(width: 5),
                            RaisedButton(child: Text("Sad"), onPressed: () {}, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                            SizedBox(width: 5),
                            RaisedButton(child: Text("Angry"), onPressed: () {}, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                            SizedBox(width: 5),
                            RaisedButton(child: Text("Fatigued"), onPressed: () {}, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                          ],
                        ),

                        SizedBox(height: 20),

                      ],
                    ),
                  ),
                ),

                // end of code



          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      color: index.isOdd ? Colors.blue[40] : Colors.blue[80],
                      height: 100.0,
                      child: Center(
                        child: Text('$index', textScaleFactor: 5),
                      ),
                    ),
                    Container(
                      color: index.isOdd ? Colors.white : Colors.black12,
                      height: 100.0,
                      child: Center(
                        child: Text('$index', textScaleFactor: 5),
                      ),
                    ),
                  ],
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
