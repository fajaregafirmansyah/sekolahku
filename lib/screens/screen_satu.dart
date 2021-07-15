import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sekolahku/screens/screen_dua.dart';

class ScreenSatu extends StatefulWidget {
  @override
  _ScreenSatuState createState() => _ScreenSatuState();
}

class _ScreenSatuState extends State<ScreenSatu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenDua()));
        },
        child: Text('screen 2'),),
    );
  }
}