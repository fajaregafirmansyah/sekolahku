import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScreenDua extends StatefulWidget {
  @override
  _ScreenDuaState createState() => _ScreenDuaState();
}

class _ScreenDuaState extends State<ScreenDua> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextButton(
        onPressed: (){
         Navigator.pop(context);
         
         },
        child: Text('screen 2'),),
    );
  }
}