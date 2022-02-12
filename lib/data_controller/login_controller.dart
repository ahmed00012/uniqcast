import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:overlay_support/overlay_support.dart';
import 'package:uniqcast/constants.dart';
import 'local_storage.dart';

final userFuture = ChangeNotifierProvider.autoDispose<LoginController>(
    (ref) => LoginController());

class LoginController extends ChangeNotifier {
  FocusNode nameFocusNode = new FocusNode();
  FocusNode passwordFocusNode = new FocusNode();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool seePassword = true;
  final formKey = GlobalKey<FormState>();

  LoginController() {
    changeState(nameFocusNode, passwordFocusNode);
  }

  controlSeePassword() {
    seePassword = !seePassword;
    notifyListeners();
  }

  changeState(FocusNode nameFocusNode, FocusNode passwordFocusNode) {
    nameFocusNode.addListener(() {
      notifyListeners();
    });
    passwordFocusNode.addListener(() {
      notifyListeners();
    });
  }

  Future getData(String name, String password) async {
    try {
      http.Response response = await http.post(
          Uri.parse("http://devel.uniqcast.com:3001/auth/local"),
          body: {"identifier": name, "password": password});

      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        LocalStorage.saveData(key: 'token', value: data['jwt']);
        LocalStorage.saveData(key: 'name', value: data['user']['username']);
        showSimpleNotification(
            Center(child: Text("welcome ${data['user']['username']}")),
            background: Constants.mainColor);
        return true;
      } else {
        showSimpleNotification(
            Center(child: Text("Wrong username or password")),
            background: Constants.mainColor);
        return false;
      }
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }
}
