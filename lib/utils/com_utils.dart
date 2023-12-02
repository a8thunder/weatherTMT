import 'package:flutter/material.dart';

class CommonUtils {
  static Widget get appDivider => const Divider(
        color: Colors.white,
      );

  static unfocusKeyboard(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
