import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/commens/constants.dart';
import 'package:my_ecommerce_app/commens/loading.dart';
import 'package:my_ecommerce_app/commens/route_commens.dart';
import 'package:my_ecommerce_app/db/users_services.dart';
import 'package:my_ecommerce_app/provider/user_provider.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formkey = new GlobalKey<FormState>();
  final _key = new GlobalKey<ScaffoldState>();

  TextEditingController _emailTextController = new TextEditingController();
  TextEditingController _passTextController = new TextEditingController();
  TextEditingController _confirmPassTextController =
      new TextEditingController();
  TextEditingController _nameTextController = new TextEditingController();
  bool loading = false;
  String groupValue = "mail";
  String gender;
  bool hidePass = true;

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
                  color: Colors.black.withOpacity(0.7),
                  width: double.infinity,
                  height: double.infinity,
                ),
                Container(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: 240,
                    height: 240,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 150.0),
                    child: Center(
                      child: Form(
                        key: _formkey,
                        child: ListView(
                          children: <Widget>[
                            //full name Text
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white.withOpacity(0.4),
                                elevation: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        hintText: "Full name",
                                        icon: Icon(Icons.person_outline),
                                        border: InputBorder.none),
                                    controller: _nameTextController,
                                    //keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Name cant be Empty";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),

                            // Email Text Field
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white.withOpacity(0.4),
                                elevation: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        hintText: "Email",
                                        icon: Icon(Icons.alternate_email),
                                        border: InputBorder.none),
                                    controller: _emailTextController,
                                    //keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        Pattern pattern =
                                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                        RegExp regExp = new RegExp(pattern);
                                        if (!regExp.hasMatch(value))
                                          return "Please Make Sure your email is valid ";
                                        else
                                          return null;
                                      }
                                      return null;
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
                                color: Colors.white.withOpacity(0.4),
                                elevation: 0.0,
                                child: ListTile(
                                    dense: true,
                                    title: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Password",
                                          icon: Icon(Icons.lock_outline),
                                          border: InputBorder.none),
                                      obscureText: hidePass,
                                      controller: _passTextController,
                                      //keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        if (value.isEmpty)
                                          return "The Password must be Not Empty";
                                        else if (value.length < 6)
                                          return "The password has to be more than 6 charcters";
                                        return null;
                                      },
                                    ),
                                    trailing: IconButton(
                                        icon: Icon(Icons.remove_red_eye),
                                        onPressed: () {
                                          setState(() {
                                            hidePass = false;
                                          });
                                        })),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white.withOpacity(0.4),
                                elevation: 0.0,
                                child: ListTile(
                                    dense: true,
                                    title: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Confirm password",
                                          icon: Icon(Icons.lock_outline),
                                          border: InputBorder.none),
                                      obscureText: hidePass,
                                      controller: _confirmPassTextController,
                                      //keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        if (value.isEmpty)
                                          return "The Password must be Not Empty";
                                        else if (value.length < 6)
                                          return "The password has to be more than 6 charcters";
                                        else if (_passTextController.text !=
                                            value)
                                          return "the password must be match";

                                        return null;
                                      },
                                    ),
                                    trailing: IconButton(
                                        icon: Icon(Icons.remove_red_eye),
                                        onPressed: () {
                                          setState(() {
                                            hidePass = false;
                                          });
                                        })),
                              ),
                            ),

                            //Select Gender
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white.withOpacity(0.4),
                                elevation: 0.0,
                                child: Container(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: ListTile(
                                          dense: false,
                                          title: Text("Male",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          trailing: Radio(activeColor: kPrimaryColor,
                                              value: "Male",
                                              groupValue: groupValue,
                                              onChanged: (e) =>
                                                  valueChanged(e)),
                                        ),
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          dense: false,
                                          title: Text("Female",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          trailing: Radio(
                                              activeColor: kPrimaryColor,
                                              value: "Female",
                                              groupValue: groupValue,
                                              onChanged: (e) =>
                                                  valueChanged(e)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            //Register Button
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color:kPrimaryColor.withOpacity(0.8),
                                  elevation: 0.0,
                                  child: MaterialButton(
                                    onPressed: () async {
                                      if (_formkey.currentState.validate()) {
                                        bool x=await user.signUp(
                                            _nameTextController.text,
                                            gender,
                                            _emailTextController.text,

                                            _passTextController.text);
                                        print (x);
                                        if (!x) {
                                          _key.currentState.showSnackBar(
                                              SnackBar(
                                                  content:
                                                      Text("Sign up Failed ")));
                                        } else {
                                          /// To-DO : Fixing
                                         // return Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>HomePage()));
                                               Navigator.pop(context);
                                        }
                                      }
                                    },
                                    minWidth: MediaQuery.of(context).size.width,
                                    child: new Text(
                                      "Register",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 20.0),
                                    ),
                                  )),
                            ),

                            //Text for SignIn
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    style: TextStyle(color: Colors.white),
                                    children: [
                                      TextSpan(
                                          text: "Already have an account?  "),
                                      TextSpan(
                                          text: "Sign in",
                                          recognizer: new TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.pop(context);
                                            },
                                          style: TextStyle(
                                            color: kPrimaryColor,
                                          ))
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
                        valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }

  //Select Gender
  valueChanged(e) {
    setState(() {
      if (e == "Male") {
        groupValue = e;
        gender = e;
      } else if (e == "Female") {
        groupValue = e;
        gender = e;
      }
    });
  }
}
