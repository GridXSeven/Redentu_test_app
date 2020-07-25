import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/data/data.dart';
import 'package:testapp/widgets/custom_button.dart';
import 'package:testapp/constants/constants.dart';

class ProfileScreen extends StatefulWidget {
  static String id = '/profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String login;
  String password;
  String name;
  String age;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Provider.of<MyData>(context).me != null
            ? Provider.of<MyData>(context).me.login
            : "ANONYM"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(child: Text("name")),
                Expanded(
                  flex: 2,
                  child: TextField(
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      name = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: Provider.of<MyData>(context).me != null
                            ? (Provider.of<MyData>(context).me.name != null
                                ? Provider.of<MyData>(context).me.name
                                : "Enter your name")
                            : "Enter your name"),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(child: Text("login")),
                Expanded(
                  flex: 2,
                  child: TextField(
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      login = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: Provider.of<MyData>(context).me != null
                            ? (Provider.of<MyData>(context).me.login != null
                                ? Provider.of<MyData>(context).me.login
                                : "Enter your login")
                            : "Enter your login"),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(child: Text("password")),
                Expanded(
                  flex: 2,
                  child: TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: Provider.of<MyData>(context).me != null
                            ? (Provider.of<MyData>(context).me.password != null
                                ? Provider.of<MyData>(context).me.password
                                : "Enter your password")
                            : "Enter your password"),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(child: Text("age")),
                Expanded(
                  flex: 2,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      age = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: Provider.of<MyData>(context).me != null
                            ? (Provider.of<MyData>(context).me.age != null
                                ? Provider.of<MyData>(context).me.age
                                : "Enter your age")
                            : "Enter your age"),
                  ),
                ),
              ],
            ),
            CustomButton(
                color: Colors.red,
                text: "SAVE",
                onTap: () {
                  Provider.of<MyData>(context, listen: false).changeUser(
                      login: login, password: password, name: name, age: age);
                }),
            CustomButton(
                color: Colors.red,
                text: "LOG OUT",
                onTap: () {
                  Provider.of<MyData>(context, listen: false).logout();
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
