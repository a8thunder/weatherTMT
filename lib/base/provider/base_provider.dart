import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class BaseProvider extends ChangeNotifier {
  void loading() {
    EasyLoading.show();
  }

  void dismissLoading() {
    EasyLoading.dismiss();
  }

  void loader(bool active) {
    active ? loading() : dismissLoading();
  }

  void notify() {
    notifyListeners();
  }
}
