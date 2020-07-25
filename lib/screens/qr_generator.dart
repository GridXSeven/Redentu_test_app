import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:testapp/constants/constants.dart';
import 'package:testapp/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:testapp/data/data.dart';

class QRGenerator extends StatefulWidget {
  static String id = '/qr';

  @override
  _QRGeneratorState createState() => _QRGeneratorState();
}

class _QRGeneratorState extends State<QRGenerator> {
  String code;

  QrImage img;

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
        child: ListView(
          children: <Widget>[
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                code = value;
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: "Enter QR token"),
            ),
            CustomButton(
                color: Colors.red,
                text: "ok",
                onTap: () {
                  var qr = QrImage(
                    data: code,
                    version: QrVersions.auto,
                    size: 200.0,
                    gapless: false,
                  );
                  print(qr);
                  setState(() {
                    img = qr;
                  });
                }),
            Container(
              child: Center(child: img != null ? img : Container()),
              height: 400,
              width: double.maxFinite,
              color: Colors.white70,
            ),
          ],
        ),
      ),
    );
  }
}
