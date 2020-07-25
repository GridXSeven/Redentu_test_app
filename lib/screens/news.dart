import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/data/data.dart';
import 'package:testapp/screens/qr_generator.dart';
import 'package:testapp/screens/profile.dart';
import 'package:testapp/widgets/search_dialog.dart';

class NewsScreen extends StatefulWidget {
  static String id = '/news';

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  void _showDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SearchedDialog();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'logo',
                child: Container(
                  height: 50.0,
                  child: Image.asset('assets/news_icon.png'),
                ),
              ),
            ),
            Text(Provider.of<MyData>(context).me != null
                ? Provider.of<MyData>(context).me.login
                : "ANONYM"),
          ],
        ),
        actions: <Widget>[
          Visibility(
            visible: Provider.of<MyData>(context, listen: false).me != null,
            child: IconButton(
              icon: Icon(Icons.person_outline),
              onPressed: () =>
                  Provider.of<MyData>(context, listen: false).me != null
                      ? Navigator.pushNamed(context, ProfileScreen.id)
                      : null,
            ),
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => _showDialog(),
          ),
          IconButton(
            icon: Icon(Icons.rounded_corner),
            onPressed: () => Navigator.pushNamed(context, QRGenerator.id),
          ),
        ],
      ),
      body: FutureBuilder<List<Widget>>(
          future: Provider.of<MyData>(context).generateList(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              children = snapshot.data;
            } else if (snapshot.hasError) {
              children = <Widget>[
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                )
              ];
            } else {
              return Container(
                height: double.maxFinite,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        child: CircularProgressIndicator(),
                        width: 60,
                        height: 60,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text('Awaiting result...'),
                      )
                    ],
                  ),
                ),
              );
            }
            return Center(
              child: ListView(
                children: children,
              ),
            );
          }),
    );
  }
}
