import 'package:flutter/material.dart';

/// 路由跳转，获取传参数据
class NavigatorUtil {

  // static push(BuildContext context, Widget page) {
  //   // Navigator.of(context).push(FadeRoute(page));
  // }
  //
  // /// 返回上一页，携带返回参数
  // static popArgs(BuildContext context, String args) {
  //   Navigator.of(context).pop(args);
  // }

  /// 跳转，不传参
  static String pushNamed(BuildContext context, String routeName) {
    return Navigator.restorablePushNamed(context,routeName);
  }

  /// 跳转，传参
  static String pushNamedArgs(BuildContext context, String routeName, Object args) {
    return Navigator.restorablePushNamed(context, routeName, arguments: args);
  }

  // /// 获取传递的参数
  // static Future<Object> getArgs(BuildContext context) {
  //   return Future.delayed(Duration.zero, () {
  //     final Object message = ModalRoute.of(context)!.settings.arguments as String;
  //     // Logs.logd("传递的参数", message);
  //     return message;
  //   });
  // }
  //
  // /// 把栈内的widget全部弹出，栈内只剩跳转的widget
  // static Future pushNamedAndRemoveUntil(BuildContext context, String routeName) {
  //   return  Navigator.of(context).pushNamedAndRemoveUntil(routeName, (Route route) => false);
  // }
}
