import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HealthGraph extends StatefulWidget {
  const HealthGraph({Key? key}) : super(key: key);

  @override
  State<HealthGraph> createState() => _HealthGraphState();
}

class _HealthGraphState extends State<HealthGraph> {

  @override
  Widget build(BuildContext context) {

    final users = FirebaseAuth.instance.currentUser;

    Future<DocumentSnapshot> getUserInfo()async{
      return await FirebaseFirestore.instance.collection("userData").doc(users!.uid).get();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Mental Health Chart"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getUserInfo(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done)
          {
            List dates = (snapshot.data!.data() as Map<String, dynamic>)['date'];
            List points = (snapshot.data!.data() as Map<String, dynamic>)['dtime,points'];

            // data
            final List<PointData> data = [];
            final DateTime firstvalue = DateTime.parse(points[0].toString().split(',')[0]);

            for (int i=0;i<points.length;i++) {
              data.add(PointData(DateTime.parse(points[i].toString().split(',')[0]), double.parse(points[i].toString().split(',')[1])));
            }

            /*
            return ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title:
                    Text(points[1].toString().split(',')[0]),
                  );
                });

*/
            return SafeArea(
                child: Container(
                    child: SfCartesianChart(
                        primaryXAxis: DateTimeAxis(
                          /*minimum: firstvalue,
                          maximum: DateTime.now(),*/
                          interval: 1,
                        ),
                        primaryYAxis: NumericAxis(
                          minimum: 1,
                          maximum: 9,
                          interval: 1,
                        ),
                        series: <ChartSeries<PointData, DateTime>>[
                          // Renders line chart
                          LineSeries<PointData, DateTime>(
                              dataSource: data,
                              xValueMapper: (PointData data, _) => data.dateobj,
                              yValueMapper: (PointData data, _) => data.mood_value,
                          )
                        ]
                    )
                )
            );


          }
          else if (snapshot.connectionState == ConnectionState.none)
          {
            return Text("No data");
          }
          else
            return CircularProgressIndicator();
        },
      ),
    );
  }
}

class PointData {
  final DateTime dateobj;
  final double mood_value;

  PointData(this.dateobj, this.mood_value);
}