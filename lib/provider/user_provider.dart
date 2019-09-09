import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:my_ecommerce_app/db/users_services.dart';

enum Status {
  UnInitialized, Authenticating, Authenticated, UnAuthenticated }

class UserProvider with ChangeNotifier {
  Status _status = Status.UnInitialized;
  FirebaseUser _user;
  FirebaseAuth _auth;

  UserServices userServices = new UserServices();

  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onAuthChanged);
  }

  Status get status => _status;

  FirebaseUser get user => _user;

  Future<bool> signIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      _user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return true;
    }
    catch(e){
      print(e.toString());
      _status = Status.UnAuthenticated;
      notifyListeners();
      return false;
    }


  }

  Future<bool> signUp (
      String name, String gender, String email, String password) async {
    _status = Status.Authenticating;
    notifyListeners();
    try {
       await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) {
        Map<String, dynamic> data = {
          "email": email,
          "password": password,
          "name": name,
          "gender": gender,
          "userId": user.uid
        };
        userServices.createUser(data);

      });
       return true;
    } catch (e) {
      print(e.toString());
      _status = Status.UnAuthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut()async {

    _auth.signOut();
    _status = Status.UnAuthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void _onAuthChanged(FirebaseUser user) async  {
    if (user == null) {
      _status = Status.UnAuthenticated;

    } else {
      _user = user;
      _status = Status.Authenticated;

    }
    notifyListeners();
  }
}
