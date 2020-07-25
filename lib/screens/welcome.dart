import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/data/data.dart';
import 'package:testapp/screens/register.dart';
import 'package:testapp/screens/login.dart';
import 'package:testapp/screens/news.dart';
import 'package:testapp/widgets/custom_button.dart';
import 'package:image_picker/image_picker.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = '/welcome';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      if (await Provider.of<MyData>(context, listen: false)
          .uploadUserFromCache()) {
        Navigator.pushNamed(context, NewsScreen.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.camera),
                        title: Text('Camera'),
                        onTap: () {
                          var image = ImageSource.camera;
                          Navigator.pop(context);
                          Provider.of<MyData>(context, listen: false)
                              .takeImage(image);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.image),
                        title: Text('Gallery'),
                        onTap: () {
                          var image = ImageSource.gallery;
                          Navigator.pop(context);
                          Provider.of<MyData>(context, listen: false)
                              .takeImage(image);
                        },
                      ),
                    ],
                  ),
                );
              });
        },
        tooltip: 'New Image',
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 400.0,
                    child: Image.asset('assets/news_icon.png'),
                  ),
                ),
              ),
              Hero(
                child: CustomButton(
                  color: Colors.red,
                  text: "LOGIN",
                  onTap: () => Navigator.pushNamed(context, LoginScreen.id),
                ),
                tag: "login",
              ),
              Hero(
                tag: "register",
                child: CustomButton(
                  color: Colors.red,
                  text: "REGISTER",
                  onTap: () =>
                      Navigator.pushNamed(context, RegistrationScreen.id),
                ),
              ),
              CustomButton(
                color: Colors.red,
                text: "ANONYMOUS LOGIN",
                onTap: () => Navigator.pushNamed(context, NewsScreen.id),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
