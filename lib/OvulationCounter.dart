import 'package:flutter/material.dart';

class OvulationCounter extends StatefulWidget {
  const OvulationCounter({Key? key}) : super(key: key);

  @override
  State<OvulationCounter> createState() => _OvulationCounterState();
}

class _OvulationCounterState extends State<OvulationCounter> {

  DateTime pickedDate = DateTime.now();
  DateTime finalDate = DateTime.now();
  int cycleDays = 28;

  void _showDatePicker()
  {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    ).then((value) {
      setState(() {
        pickedDate = value!;
      });
    });
  }

  void incrementDays()
  {
    setState(() {
      cycleDays++;
    });
  }

  void decrementDays()
  {
    setState(() {
      cycleDays--;
    });
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
                  Colors.redAccent.withOpacity(0.15),
                  Colors.redAccent.withOpacity(0.5),
                ]
            )
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(90),
                    bottomRight: Radius.circular(90),
                  )),
              pinned: true,
              snap: false,
              floating: false,
              forceElevated: true,
              elevation: 10,
              expandedHeight: 200,
              backgroundColor: Colors.redAccent.withOpacity(0.6),
              flexibleSpace: const FlexibleSpaceBar(
                titlePadding: EdgeInsets.only(bottom: 60),
                centerTitle: true,
                title: Text("Ovulation Calculator",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),

                    Text("Pick your last period date:", style: TextStyle(fontSize: 20)),

                    SizedBox(height: 20),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: RaisedButton(
                        color: Colors.grey[100],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 4.0,
                        onPressed: _showDatePicker,
                        child:Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          alignment: Alignment.center,
                          height: 50.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.date_range,
                                          size: 18.0,
                                          color: Colors.red.withOpacity(0.9),
                                        ),
                                        Text(
                                          '  ${pickedDate.day}/${pickedDate.month}/${pickedDate.year}',
                                          style: TextStyle(
                                              color: Colors.redAccent.withOpacity(0.8),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                "  Change",
                                style: TextStyle(
                                    color: Colors.redAccent.withOpacity(0.8),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 50),

                    Text("Pick your average cycle (days):", style: TextStyle(fontSize: 20)),

                    SizedBox(height: 20),

                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FloatingActionButton(
                          heroTag: "btn1",
                          backgroundColor: Colors.redAccent,
                          child: Icon(Icons.remove),
                          mini: true,
                          onPressed: decrementDays,
                        ),
                        Text("${cycleDays}", style: TextStyle(fontSize: 60)),
                        FloatingActionButton(
                          heroTag: "btn2",
                          backgroundColor: Colors.redAccent,
                          child: Icon(Icons.add),
                          mini: true,
                          onPressed: incrementDays,
                        ),
                      ],
                    ),

                    SizedBox(height: 80),

                    RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        elevation: 7,
                        color: Colors.redAccent.shade200,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                          child: Text("See Results", style: TextStyle(fontSize: 20, color: Colors.white)),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => OvulationResult(pickedDate: pickedDate, cycleDays: cycleDays))
                          );
                        }
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OvulationResult extends StatefulWidget {

  final DateTime pickedDate;
  final int cycleDays;

  const OvulationResult({Key? key, required this.pickedDate, required this.cycleDays}) : super(key: key);

  @override
  State<OvulationResult> createState() => _OvulationResultState();
}

class _OvulationResultState extends State<OvulationResult> {

  DateTime ferWinSt = DateTime.now();
  DateTime ferWinEnd = DateTime.now();
  DateTime ovulate = DateTime.now();
  DateTime nextPeriod = DateTime.now();
  DateTime pregCheck = DateTime.now();

  void calculateAllData()
  {
    ovulate = widget.pickedDate.add(Duration(days: 14 + (widget.cycleDays - 28) - 1));
    ferWinSt = ovulate.subtract(const Duration(days: 3));
    ferWinEnd = ovulate.add(const Duration(days: 1));
    nextPeriod = widget.pickedDate.add(Duration(days: widget.cycleDays - 1));
    pregCheck = nextPeriod.add(const Duration(days: 1));
  }

  @override
  void initState() {
    super.initState();
    calculateAllData();
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
                      Colors.redAccent.withOpacity(0.15),
                      Colors.redAccent.withOpacity(0.5),
                    ]
                )
            ),
            child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(90),
                          bottomRight: Radius.circular(90),
                        )
                    ),
                    pinned: true,
                    snap: false,
                    floating: false,
                    forceElevated: true,
                    elevation: 10,
                    expandedHeight: 120,
                    backgroundColor: Colors.redAccent.withOpacity(0.6),
                    flexibleSpace: const FlexibleSpaceBar(
                      titlePadding: EdgeInsets.only(bottom: 30),
                      centerTitle: true,
                      title: Text("Results",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        /*
                      Text("Fertile Start: " + ferWinSt.toString()),
                      Text("Fertile End: " + ferWinEnd.toString()),
                      Text("Approx. Ovulation: " + ovulate.toString()),
                      Text("Next Period: " + nextPeriod.toString()),
                       */

                        SizedBox(height: 20),

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 25.0),
                                    child: Column(
                                      children: [
                                        Container(
                                            width: 55.0,
                                            height: 55.0,
                                            decoration: new BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: new DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage('assets/images/fertile_period.png')
                                                )
                                            )
                                        ),
                                        SizedBox(height: 5),
                                        Text(" FERTILE\nWINDOW", style: TextStyle(fontSize: 12)),

                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 70.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("Your Fertile Window is:",
                                          style: TextStyle (
                                            color: Colors.redAccent,
                                            fontSize: 16,
                                          ),
                                        ),

                                        SizedBox(height: 5),

                                        RichText(
                                          text: TextSpan(
                                              style: TextStyle (
                                                  color: Colors.redAccent,
                                                  fontSize: 24
                                              ),
                                              children: [
                                                TextSpan(text: ferWinSt.day.toString(), style: TextStyle(fontSize: 36)),
                                                TextSpan(text: "/", style: TextStyle(fontSize: 28)),
                                                TextSpan(text: ferWinSt.month.toString(), style: TextStyle(fontSize: 28)),
                                                TextSpan(text: "  to  "),
                                                TextSpan(text: ferWinEnd.day.toString(), style: TextStyle(fontSize: 36)),
                                                TextSpan(text: "/", style: TextStyle(fontSize: 28)),
                                                TextSpan(text: ferWinEnd.month.toString(), style: TextStyle(fontSize: 28)),
                                              ]
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 25.0),
                                    child: Column(
                                      children: [
                                        Container(
                                            width: 55.0,
                                            height: 55.0,
                                            decoration: new BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: new DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage('assets/images/ovulate.png')
                                                )
                                            )
                                        ),
                                        SizedBox(height: 5),
                                        Text("OVULATION", style: TextStyle(fontSize: 12)),

                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 60.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("Approx. Ovulation Date:",
                                          style: TextStyle (
                                            color: Colors.redAccent,
                                            fontSize: 16,
                                          ),
                                        ),

                                        SizedBox(height: 5),

                                        RichText(
                                          text: TextSpan(
                                              style: TextStyle (
                                                  color: Colors.redAccent,
                                                  fontSize: 24
                                              ),
                                              children: [
                                                TextSpan(text: ovulate.day.toString(), style: TextStyle(fontSize: 36)),
                                                TextSpan(text: "/", style: TextStyle(fontSize: 28)),
                                                TextSpan(text: ovulate.month.toString(), style: TextStyle(fontSize: 28)),
                                              ]
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),

                        // paste here
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 25.0),
                                    child: Column(
                                      children: [
                                        Container(
                                            width: 55.0,
                                            height: 55.0,
                                            decoration: new BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: new DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage('assets/images/period.png')
                                                )
                                            )
                                        ),
                                        SizedBox(height: 5),
                                        Text("NEXT PERIOD", style: TextStyle(fontSize: 12)),

                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 50.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("Next Period is due on:",
                                          style: TextStyle (
                                            color: Colors.redAccent,
                                            fontSize: 16,
                                          ),
                                        ),

                                        SizedBox(height: 5),

                                        RichText(
                                          text: TextSpan(
                                              style: TextStyle (
                                                  color: Colors.redAccent,
                                                  fontSize: 24
                                              ),
                                              children: [
                                                TextSpan(text: nextPeriod.day.toString(), style: TextStyle(fontSize: 36)),
                                                TextSpan(text: "/", style: TextStyle(fontSize: 28)),
                                                TextSpan(text: nextPeriod.month.toString(), style: TextStyle(fontSize: 28)),
                                              ]
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 25.0),
                                    child: Column(
                                      children: [
                                        Container(
                                            width: 55.0,
                                            height: 55.0,
                                            decoration: new BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: new DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage('assets/images/fertile_period.png')
                                                )
                                            )
                                        ),
                                        SizedBox(height: 10),
                                        Text("PREGNANCY\n TEST DATE", style: TextStyle(fontSize: 12)),

                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 55.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("Pregnancy Test Date\n(if expecting):",
                                          style: TextStyle (
                                            color: Colors.redAccent,
                                            fontSize: 16,
                                          ),
                                        ),

                                        SizedBox(height: 5),

                                        RichText(
                                          text: TextSpan(
                                              style: TextStyle (
                                                  color: Colors.redAccent,
                                                  fontSize: 24
                                              ),
                                              children: [
                                                TextSpan(text: pregCheck.day.toString(), style: TextStyle(fontSize: 36)),
                                                TextSpan(text: "/", style: TextStyle(fontSize: 28)),
                                                TextSpan(text: pregCheck.month.toString(), style: TextStyle(fontSize: 28)),
                                              ]
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),


                      ],
                    ),
                  )
                ]
            )
        )
    );
  }
}

