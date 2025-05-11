import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserWebService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  Future<Map<String,dynamic>> getUserFromFirebase() async{
    if(_auth.currentUser != null){
      Map<String,dynamic> userMap = (await _database.collection("users")
          .doc(_auth.currentUser!.uid)
          .get()).data()!;
      return userMap;
    }
    else{
      throw Exception("There's no user");
    }
  }
}