import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ImageHelper {
  static Widget appIcon({
    required IconData icon,
    Color? color,
  }) =>
      FaIcon(
        icon,
        color: color ?? Colors.white,
      );
}
