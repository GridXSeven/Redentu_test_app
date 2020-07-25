import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/data/data.dart';
import 'package:testapp/screens/login.dart';
import 'package:testapp/screens/news.dart';
import 'package:testapp/screens/profile.dart';
import 'package:testapp/screens/qr_generator.dart';
import 'package:testapp/screens/register.dart';
import 'package:testapp/screens/welcome.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyData>(
      create: (context) => MyData(),
      child: MaterialApp(
        theme: ThemeData.dark(),
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          QRGenerator.id: (context) => QRGenerator(),
          ProfileScreen.id: (context) => ProfileScreen(),
          NewsScreen.id: (context) => NewsScreen(),
        },
      ),
    );
  }
}
