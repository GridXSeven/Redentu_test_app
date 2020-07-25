import 'package:flutter/material.dart';
import 'package:testapp/screens/searched_news.dart';
import 'package:provider/provider.dart';
import 'package:testapp/data/data.dart';

class SearchedDialog extends StatefulWidget {
  @override
  _SearchedDialogState createState() => _SearchedDialogState();
}

class _SearchedDialogState extends State<SearchedDialog> {
  String country;
  String category;

  List<DropdownMenuItem<String>> menuGenerator() {
    List<DropdownMenuItem<String>> myList = [];
    for (var i = 0; i < 5; i++) {
      var a = i + 2;
      Widget myWidget = DropdownMenuItem(
        child: Text(a.toString()),
        value: a.toString(),
      );
      myList.add(myWidget);
    }
    return myList;
  }

  List<DropdownMenuItem<String>> countryGenerator() {
    List<DropdownMenuItem<String>> myList = [];
    for (var item in Provider.of<MyData>(context).country) {
      Widget myWidget = DropdownMenuItem(
        child: Text(item),
        value: item,
      );
      myList.add(myWidget);
    }
    return myList;
  }

  List<DropdownMenuItem<String>> categoryGenerator() {
    List<DropdownMenuItem<String>> myList = [];
    for (var item in Provider.of<MyData>(context).category) {
      Widget myWidget = DropdownMenuItem(
        child: Text(item),
        value: item,
      );
      myList.add(myWidget);
    }
    return myList;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Search by params"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Country"),
              DropdownButton<String>(
                value: country,
                onChanged: (v) {
                  setState(() {
                    country = v;
                  });
                },
                items: countryGenerator(),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Category"),
              DropdownButton<String>(
                value: category,
                onChanged: (v) {
                  setState(() {
                    category = v;
                  });
                },
                items: categoryGenerator(),
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new FlatButton(
          child: new Text("ok"),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchedNews(
                  category: category,
                  country: country,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
