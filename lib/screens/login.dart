import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/commens/constants.dart';
import 'package:my_ecommerce_app/commens/loading.dart';

import 'package:my_ecommerce_app/db/users_services.dart';
import 'package:my_ecommerce_app/provider/user_provider.dart';
import 'package:my_ecommerce_app/screens/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  SharedPreferences preferences;
  bool loading = false;
  bool isLoggedIn = false;

  final _formkey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  TextEditingController _emailTextController = new TextEditingController();
  TextEditingController _passTextController = new TextEditingController();

  UserServices userServices = new UserServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //isSignedIn();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _key,
      body: user.status == Status.Authenticating
          ? Loading()
          : Stack(
              children: <Widget>[
                Image.asset("assets/images/back.png",
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity),
                Container(
                  color: Colors.black.withOpacity(0.4),
                  width: double.infinity,
                  height: double.infinity,
                ),
                Container(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: 280,
                    height: 240,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 200.0),
                    child: Center(
                      child: Form(
                        key: _formkey,
                        child: ListView(
                          children: <Widget>[
                            // Email Text Field
                            //TODO- SignEmail
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white.withOpacity(0.8),
                                elevation: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: "Email",
                                      icon: Icon(Icons.alternate_email),
                                    ),
                                    controller: _emailTextController,
                                    //keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Email cant be Empty ! ";
                                      } else {
                                        Pattern pattern =
                                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                        RegExp regExp = new RegExp(pattern);
                                        if (!regExp.hasMatch(value))
                                          return "Please Make Sure your email is valid ";
                                        else
                                          return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),

                            // password Text Field
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white.withOpacity(0.8),
                                elevation: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: "Password",
                                      icon: Icon(Icons.lock_outline),
                                    ),
                                    controller: _passTextController,
                                    //keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value.isEmpty)
                                        return "The Password must be Not Empty";
                                      else if (value.length < 6)
                                        return "The password has to be more than 6 charcters";
                                      else
                                        return null;
                                    },
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: kPrimaryColor.withOpacity(0.8),
                                  elevation: 0.0,
                                  child: MaterialButton(
                                    onPressed: () async {
                                      if (_formkey.currentState.validate()) {
                                        bool x = await user.signIn(
                                            _emailTextController.text,
                                            _passTextController.text);
                                        if (!x) {
                                          _key.currentState.showSnackBar(
                                              SnackBar(
                                                  content:
                                                      Text("Sign in Failed ")));
                                        } else {
                                          //return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
                                        }
                                      }
                                    },
                                    minWidth: MediaQuery.of(context).size.width,
                                    child: new Text(
                                      "Login",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 20.0),
                                    ),
                                  )),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Forget password",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                    children: [
                                      TextSpan(
                                          text:
                                              "Don't have an account? click here to"),
                                      TextSpan(
                                          text: " sign up!",
                                          recognizer: new TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Register()));
                                            },
                                          style: TextStyle(color: kPrimaryColor,fontWeight: FontWeight.bold))
                                    ]),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: loading ?? true,
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.white.withOpacity(0.7),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailTextController.dispose();
    _passTextController.dispose();

  }
}
