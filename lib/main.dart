import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:uniqcast/constants.dart';
import 'data_controller/local_storage.dart';
import 'home.dart';
import 'login.dart';




void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget home = Scaffold();

  localStorageInitialize() async {
    await LocalStorage.init();
    setState(() {
      LocalStorage.getData(key: 'token') != null
          ? home = Home()
          : home = Login();
    });
  }



  @override
  void initState() {
    localStorageInitialize();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: Constants.secondaryColor,
        ),
      ),
      home: home,
    ));
  }
}
