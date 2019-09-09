import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/provider/cart_provider.dart';
import 'package:my_ecommerce_app/provider/user_provider.dart';
import 'package:my_ecommerce_app/screens/home.dart';
import 'package:my_ecommerce_app/screens/login.dart';
import 'package:provider/provider.dart';
import './provider/theme_provider.dart';
import 'commens/constants.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(builder: (context) => CartProvider()),
    ChangeNotifierProvider(builder: (context) => UserProvider.initialize()),
    ChangeNotifierProvider(
        builder: (context) => ThemeChanger(
            ThemeData.light().copyWith(primaryColor: kPrimaryColor))),
    // Colorhttps://github.com/AhmedFahmy9549/Flushion-Flutter.git(0xFFB33771)
  ], child: Splash()));
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme.getTheme(),
        home: ScreensController());
  }
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
        //check Status
    switch (user.status) {
      case Status.UnInitialized:
        print("Status From Main = ${user.status}");
        return Login();
      case Status.Authenticated:
        print("Status From Main = ${user.status}");
        return HomePage();
      case Status.UnAuthenticated:
        print("Status From Main = ${user.status}");
        return Login();

      case Status.Authenticating:
        print("Status From Main = ${user.status}");
        return Login();

      default:
        print("Status From Main = ${user.status}");
        return Login();
    }
  }
}
