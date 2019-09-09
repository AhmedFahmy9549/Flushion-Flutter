import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/commens/constants.dart';
import 'package:my_ecommerce_app/components/list_horizontal.dart';
import 'package:my_ecommerce_app/components/recent_product.dart';
import 'package:my_ecommerce_app/provider/cart_provider.dart';
import 'package:my_ecommerce_app/provider/theme_provider.dart';
import 'package:my_ecommerce_app/provider/user_provider.dart';
import 'package:my_ecommerce_app/screens/about.dart';
import 'package:my_ecommerce_app/screens/contact.dart';
import 'package:my_ecommerce_app/screens/myAccount.dart';
import 'package:my_ecommerce_app/screens/settings.dart';
import 'package:provider/provider.dart';

import 'cart.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateHomePage();
  }
}

class StateHomePage extends State<HomePage> {
  bool darkmode = false;

  @override
  Widget build(BuildContext context) {
   final bloc = Provider.of<CartProvider>(context);
    final user = Provider.of<UserProvider>(context);
   final ThemeChanger theme = Provider.of<ThemeChanger>(context);

    //
   // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        //backgroundColor: Colors.red,
        title: Text("Flushion"),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {}),
          new Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Container(
                height: 150.0,
                width: 30.0,
                child: new GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(),
                      ),
                    );
                  },
                  child: new Stack(
                    children: <Widget>[
                      new IconButton(
                        icon: new Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                        onPressed: null,
                      ),
                      new Positioned(
                          child: new Stack(
                            children: <Widget>[
                              new Icon(Icons.brightness_1,
                                  size: 20.0, color: Colors.green[700]),
                              new Positioned(
                                  top: 3.0,
                                  right: 7,
                                  child: new Center(
                                    child: new Text("${bloc.getCount()}"
                                      ,
                                      style: new TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )),
                            ],
                          )),
                    ],
                  ),
                )),
          )
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          padding: EdgeInsets.all(0.0),
          children: <Widget>[
            //Header
            Center(
              child: new UserAccountsDrawerHeader(
                accountName: Text("Ahmed Fahmy",style: TextStyle(color: Color(0xff232323),),textAlign: TextAlign.center,),
                accountEmail: Text("ahmedmf95@gmai.com",style: TextStyle(color: Color(0xff232323),),),
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    backgroundColor: Color(0xff232323),
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                ),
                decoration: new BoxDecoration(color: darkmode?Colors.white:kPrimaryColor),
              ),
            ),

            //Body
            InkWell(
                onTap: () {},
                child: ListTile(
                  leading: darkmode
                      ? Image.asset(
                    'assets/images/moon.png',
                    height: 30.0,
                    width: 26.0,
                  )
                      : Image.asset(
                    'assets/images/sunny.png',
                    height: 30.0,
                    width: 26.0,
                  ),
                  title: Text("DarkMode"),
                  trailing: Switch(
                    value: darkmode,
                    onChanged: (val) {
                      setState(() {
                        darkmode = val;
                      });
                      if (darkmode) {
                        theme.setTheme(ThemeData.dark().copyWith(textTheme: TextTheme(title: TextStyle(color: Colors.black))));
                      } else {
                        theme.setTheme(  ThemeData.light().copyWith(primaryColor:kPrimaryColor));
                      }
                    },
                  ),
                ),),
            InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => MyAccount()));
                },
                child: new ListTile(
                  title: Text("My account"),
                  leading: Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                )),
            InkWell(
                onTap: () {},
                child: new ListTile(
                  title: Text("My Orders"),
                  leading: Icon(
                    Icons.shopping_basket,
                    color: Colors.red,
                  ),
                )),
            InkWell(
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Contact())),
                child: new ListTile(
                  title: Text("Contact"),
                  leading: Icon(
                    Icons.contact_phone,
                    color: Color(0xff35abc9),
                  ),
                )),
            InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Settings()));
                },
                child: new ListTile(
                  title: Text("Settings"),
                  leading: Icon(
                    Icons.settings,
                    color: Colors.grey,
                  ),
                )),

            Divider(),

            InkWell(
                onTap: () {
                    user.signOut();
                    Navigator.pop(context);
                },
                child: new ListTile(
                  title: Text("LogOut"),
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Colors.blue,
                  ),
                )),

            InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => About() ));
                },
                child: new ListTile(
                  title: Text("About"),
                  leading: Icon(
                    Icons.help,
                    color: Colors.green,
                  ),
                )),
          ],
        ),
      ),
      body:  Container(
        color: Colors.grey[200],
        child: Column(
          children: <Widget>[
            //Image Carousel initialized
            getImageCarousel(),
            new Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Categroies",
                    style: TextStyle(color: Colors.black,fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                )),
            //initialize Horizontal listView
           HorizontalList1(),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 8,horizontal: 8),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Recent Produts",
                  style: TextStyle(color: Colors.black,fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            Flexible(child: Product()),
          ],
        ),
      ),
    );
  }

  Widget getImageCarousel() {
    return Container(
      height: 180,

      child: Carousel(
        overlayShadow: true,
        overlayShadowColors: Colors.black45,
        dotSize: 5.0,
        autoplay: true,
        animationCurve: Curves.bounceInOut,
        boxFit: BoxFit.cover,
        images: [
          AssetImage("assets/images/slider/cat1.png"),
          AssetImage("assets/images/slider/cat2.png"),
          AssetImage("assets/images/slider/cat3.jpg"),
          AssetImage("assets/images/slider/cat4.jpg"),

          /* AssetImage("assets/images/m1.jpeg"),
          AssetImage("assets/images/w4.jpeg"),
          AssetImage("assets/images/m2.jpg"),*/
        ],
        animationDuration: Duration(microseconds: 1000),
        //dotColor: Colors.red,
        //dotBgColor: Colors.transparent,
        indicatorBgPadding: 4.0,
      ),
    );
  }
}
