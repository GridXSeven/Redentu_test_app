import 'package:flutter/material.dart';
import 'package:testapp/constants/constants.dart';
import 'package:testapp/screens/new.dart';

class OneNewCard extends StatelessWidget {
  const OneNewCard({
    @required this.item,
  });

  final Map item;

  Image takeImage() {
    Image img;
    try {
      img = item["urlToImage"] != null
          ? Image.network(
              item["urlToImage"],
            )
          : Image.asset(defaultImagePath);
    } catch (e) {
      print(e);
      img = Image.asset(defaultImagePath);
    }
    return img;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewScreen(item: item),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            color: Color(0xff484B50),
          ),
          child: Column(
            children: <Widget>[
              takeImage(),
              item["title"] != null
                  ? CenterNewsText(item: item["title"])
                  : CenterNewsText(item: "TITEL")
            ],
          ),
        ),
      ),
    );
  }
}

class CenterNewsText extends StatelessWidget {
  const CenterNewsText({
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
        style: newsTextStyle,
      ),
    );
  }
}
