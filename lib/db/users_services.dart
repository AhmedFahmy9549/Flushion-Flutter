import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices {
  Firestore _database = Firestore.instance;
  String collection = "users";

  void createUser(data) {
    _database.collection(collection).document(data["userId"]).setData(data);
  }
   checkOut(String userId,data) {
    _database.collection(collection).document(userId).setData(data);
  }
}
