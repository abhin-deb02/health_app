import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {

  // create / update collection "userData"

  final String uid;
  DatabaseServices({ required this.uid });

  final CollectionReference userDataColl = FirebaseFirestore.instance.collection('userData');

  Future updateUserData(List<String> date, List<String> datapoints) async {
    return await userDataColl.doc(uid).set({
      'date' : date,
      'dtime,points' : datapoints,
    });
  }
}