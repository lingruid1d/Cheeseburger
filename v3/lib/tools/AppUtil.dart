import 'package:flutter/material.dart';
import 'package:flutter_1800/models/user.dart';
import 'package:get/get.dart';

class AppUtil {
  static User? user;
  //Ensure that margins are consistent throughout the application
  static double getPadding() {
    return 15;
  }

  static getTo(Widget widget) {
    Get.to(widget, transition: Transition.cupertino);
  }

  static getReplaceTo(Widget widget) {
    Get.off(widget);
  }
  //not use
  static back() {
    Get.back();
  }
}
