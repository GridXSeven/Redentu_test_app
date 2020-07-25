import 'package:flutter/material.dart';
import 'package:testapp/constants/constants.dart';
import 'package:testapp/widgets/custom_button.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = '/reg';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String login;

  String password;

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
              keyboardType: TextInputType.emailAddress,
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
              tag: 'register',
              child: CustomButton(
                onTap: () => Navigator.pop(context),
                color: Colors.red,
                text: 'REGISTER',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
