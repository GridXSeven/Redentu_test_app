import 'package:flutter/material.dart';
import 'package:testapp/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:testapp/data/data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:testapp/screens/qr_generator.dart';
import 'package:testapp/screens/profile.dart';
import 'package:testapp/widgets/search_dialog.dart';

class NewScreen extends StatefulWidget {
  static String id = '/new';
  const NewScreen({
    @required this.item,
  });

  final Map item;

  @override
  _NewScreenState createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  Image takeImage() {
    Image img;
    try {
      img = widget.item["urlToImage"] != null
          ? Image.network(
              widget.item["urlToImage"],
            )
          : Image.asset(defaultImagePath);
    } catch (e) {
      print(e);
      img = Image.asset(defaultImagePath);
    }
    return img;
  }

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
            Text(
              Provider.of<MyData>(context).me != null
                  ? Provider.of<MyData>(context).me.login
                  : "ANONYM",
              textAlign: TextAlign.center,
            ),
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
            icon: Icon(Icons.rounded_corner),
            onPressed: () => Navigator.pushNamed(context, QRGenerator.id),
          ),
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                if (widget.item["url"] != null) {
                  String url = widget.item["url"];
                  if (await canLaunch(url)) {
                    await launch(
                      url,
                      forceSafariVC: false,
                      forceWebView: false,
                      headers: <String, String>{
                        'my_header_key': 'my_header_value'
                      },
                    );
                  } else {
                    throw 'Could not launch $url';
                  }
                }
              },
              child: takeImage(),
            ),
            widget.item["author"] != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      widget.item["author"],
                      textAlign: TextAlign.left,
                      style: newsTextStyle,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      "author",
                      textAlign: TextAlign.left,
                      style: newsTextStyle,
                    ),
                  ),
            widget.item["title"] != null
                ? CenterNewText(item: widget.item["title"])
                : CenterNewText(item: "TITEL"),
            widget.item["description"] != null
                ? CenterNewText(item: widget.item["description"])
                : CenterNewText(item: "description"),
            widget.item["publishedAt"] != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      widget.item["publishedAt"],
                      textAlign: TextAlign.right,
                      style: newsTextStyle,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      "publishedAt",
                      textAlign: TextAlign.right,
                      style: newsTextStyle,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class CenterNewText extends StatelessWidget {
  const CenterNewText({
    @required this.item,
  });

  final String item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        item,
        textAlign: TextAlign.center,
        style: newTextStyle,
      ),
    );
  }
}
