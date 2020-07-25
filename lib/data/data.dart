import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:testapp/constants/constants.dart';
import 'package:testapp/widgets/new_card.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class MyData extends ChangeNotifier {
  List<String> _country = [
    "ae",
    "ar",
    "at",
    "au",
    "be",
    "bg",
    "ca",
    "ch",
    "cn",
    "ru",
    "ua",
  ];
  List<String> _category = [
    "entertainment",
    "general",
    "health",
    "science",
    "sports",
    "technology",
    "business",
  ];

  Map currentNews = {};

  User me;
  Image myImage;
  String defaultUrl =
      'http://newsapi.org/v2/top-headlines?country=ua&category=technology&apiKey=$apiKey';

  List<String> get country {
    return _country;
  }

  List<String> get category {
    return _category;
  }

  void takeImage(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source);
    print(image);
    try {
      if (image != null) {
        sendImage(image);
      }
    } catch (e) {
      print(e);
    }
  }

  void sendImage(File imageFile) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = Uri.parse("https://flutter-test.redentu.com");

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));

    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  Future<dynamic> getNews({String country, String category}) async {
    String url = defaultUrl;
    if (category != null && country != null) {
      url = 'http://newsapi.org/v2/top-headlines?' +
          'country=$country&category=$category&' +
          'apiKey=$apiKey';
    } else if (category != null) {
      url = 'http://newsapi.org/v2/top-headlines?' +
          'category=$category&' +
          'apiKey=$apiKey';
    } else if (country != null) {
      url = 'http://newsapi.org/v2/top-headlines?' +
          'country=$country&' +
          'apiKey=$apiKey';
    }

    print(url);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      currentNews = jsonDecode(response.body);
      return jsonDecode(response.body);
    } else {
      currentNews = null;
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  Future<List<Widget>> generateList({String country, String category}) async {
    List<Widget> myList = [];
    var data = await getNews(category: category, country: country);
    if (data != null) {
      List articles = data["articles"];
      for (var item in articles) {
        Widget myWidget;
        myWidget = OneNewCard(
          item: item,
        );
        myList.add(myWidget);
      }
    }
    return myList;
  }

  void saveUserToCache() async {
    Map<String, dynamic> myList = {};

    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/user_info.json');
    myList["name"] = me.name;
    myList["login"] = me.login;
    myList["password"] = me.password;
    myList["age"] = me.age;
    file.writeAsStringSync(jsonEncode(myList));
  }

  Future<bool> uploadUserFromCache() async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/user_info.json');
      Map myCache = jsonDecode(file.readAsStringSync());
      me = User(
        name: myCache["name"],
        login: myCache["login"],
        password: myCache["password"],
        age: myCache["age"],
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<dynamic> checkLastLogin() async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/user_info.json');
      Map myCache = jsonDecode(file.readAsStringSync());
      return myCache;
    } catch (e) {}
  }

  void login(String login, String password) {
    me = User(login: login, password: password);
    saveUserToCache();
    notifyListeners();
  }

  void logout() {
    me = null;
    notifyListeners();
  }

  void changeUser({String login, String password, String name, String age}) {
    login != null ? me.login = login : print(login);
    password != null ? me.password = password : print(password);
    name != null ? me.name = name : print(name);
    age != null ? me.age = age : print(age);
    saveUserToCache();
    notifyListeners();
  }
}

class User {
  User({this.login, this.password, this.name, this.age});
  String name;
  String login;
  String password;
  String age;
}
