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
  Stream<QuerySnapshot> getTask(String task) {
    return FirebaseFirestore.instance.collection(task).snapshots();
  }
  TicMethod(String id,String task)async{
    return await FirebaseFirestore.instance.collection(task).doc(id).update({"Yes":true});
  }
  DeleteTask(String id,String task)async{
    return await FirebaseFirestore.instance.collection(task).doc(id).delete();
  }
}