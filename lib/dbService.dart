import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService{
  Future addPersonalTask(Map<String,dynamic>userPersonalMap,String id)async{
    return await FirebaseFirestore.instance.collection("Personal").doc(id).set(userPersonalMap);
  }
  Future addCollegTask(Map<String,dynamic>userPersonalMap,String id)async{
    return await FirebaseFirestore.instance.collection("College").doc(id).set(userPersonalMap);
  }
  Future addOfficeTask(Map<String,dynamic>userPersonalMap,String id)async{
    return await FirebaseFirestore.instance.collection("Office").doc(id).set(userPersonalMap);
  }
}