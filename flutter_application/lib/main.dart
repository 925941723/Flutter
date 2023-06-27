import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/page/app.dart';
import 'package:flutter_application/theme/themes_controller.dart';
import 'package:flutter_application/theme/themes_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeController = ThemesController(ThemesService());
  await themeController.loadSettings();

  if(!kIsWeb){ // 非web才可以用Platform判断，否则在web使用Platform函数会报错
    // 此处只可判断原生的情况，web下的安卓跟ios判断需在MyApp的build下使用Theme.of(context).platform
    if (Platform.isAndroid) {
      print('platform android');
    }else if(Platform.isIOS){
      print('platform android');
    }
  }

  runApp(
      MyApp(themeController: themeController)
  );
}