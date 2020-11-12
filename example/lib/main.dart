import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:ecc_util/ecc_util.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String testEncStr = 'BNIL/wZOPrVGcZtAJSI82R4tZ9qQaTNg6PE31c9CnilV4YMiAQDr5OhubuezUcIMhAnoF1nijzYeTJZRDb4BefeGAaeDCoUcWBaHY05Oy5cxuoJ36KwoOiJj41HG51O1Bmy+Aq3jrC5s6KwCK8pwraayMwDaKNMjPkbzGNG9bhbL/GlEcbWghlt7SJhLp7n+Bmdum2iB0/q7M3wvHmfv/M9noMosS2Wt158SoLPUnzymvFl70aHbUnImoL5XhwcPL/WZQ3WmyyRHqU7ZZJaV8yc1mAtqPeyMaUd8HjobknQ3pgaCchThn3dxGTgzhTqdcgWj6hy2k1F0myrGhpIBwDihNE4Jnm3oI+PzKp0ddHrhpVwGSKhhvNcxM9GiBIF+PWWN0cbve0k=';
  String testDecStr = '{"iss":"XinYuan","cnt":{"uid":1,"uname":"admin","rname":"超级管理员","auths":"ROLE_0","term":1},"sub":"admin","term":1,"exp":1604523596,"iat":1604516396}';
  String testStr = '我是中国人';
  String encTestStr = '';
  String dEncTestStr = '';
  @override
  void initState() {
    super.initState();
    // initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {

    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Center(
              child: Text('Running on: $_platformVersion\n'),
            ),
            FlatButton(onPressed: ()async{
              print('startTime:${DateTime.now()}');
              encTestStr = await EccUtil.encrypt(testStr);
              print('endTime:${DateTime.now()}');
              print('encTestStr:${encTestStr}');
              setState(() {

              });
            }, child: Text('点击加密')),
            FlatButton(onPressed: ()async{
              print('startTime:${DateTime.now()}');
              dEncTestStr = await EccUtil.decrypt(testEncStr);
              print('endTime:${DateTime.now()}');
              print('dEncTestStr:${dEncTestStr}');
              // mingwen = base64Decode(dEncTestStr) as String;
              // print('mingwen:${mingwen}');
              setState(() {

              });
            }, child: Text('点击解密'))
          ],
        ),
      ),
    );
  }
}
