import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/constants/constants.dart';
import 'package:testapp/widgets/custom_button.dart';
import 'package:testapp/data/data.dart';
import 'package:testapp/screens/news.dart';
import 'package:testapp/widgets/login_alert_dialog.dart';

class LoginScreen extends StatefulWidget {
  static String id = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String login;

  String password;

  void _showDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return LoginAlertDialog();
        });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      var myMap =
          await Provider.of<MyData>(context, listen: false).checkLastLogin();
      if (await myMap != null && myMap is Map) {
        if (myMap["login"] != null) {
          setState(() {
            login = myMap["login"];
          });
        }
        if (myMap["password"] != null) {
          setState(() {
            password = myMap["password"];
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('assets/news_icon.png'),
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              controller: TextEditingController()..text = login,
              textAlign: TextAlign.center,
              onChanged: (value) {
                login = value;
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: "Enter your login"),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              controller: TextEditingController()..text = password,
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                password = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: "Enter your password"),
            ),
            SizedBox(
              height: 24.0,
            ),
            Hero(
              tag: 'login',
              child: CustomButton(
                onTap: () {
                  if (login == "User" && password == "123456") {
                    Provider.of<MyData>(context, listen: false)
                        .login(login, password);
                    Navigator.pushNamed(context, NewsScreen.id);
                  } else {
                    _showDialog();
                  }
                },
                color: Colors.red,
                text: 'LOGIN',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
