import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/kvdb/key_value_database_helper.dart';
import 'package:flutter_application/kvdb/secure_storage_processor.dart';
import 'package:flutter_application/page/app.dart';
import 'package:flutter_application/theme/themes_controller.dart';
import 'package:flutter_application/theme/themes_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 主题
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

  // if(!kIsWeb && (Platform.isAndroid || Platform.isIOS)){ // 安卓或ios原生
  //   await KeyValueDatabaseHelper().init(MMKVProcessor()); // 只有打包安卓的时候采用mmvk，否则会报错
  // }else{
  //   await KeyValueDatabaseHelper().init(SharedPreferencesProcessor());
  // }

  await KeyValueDatabaseHelper().init(SecureStorageProcessor());
  await KeyValueDatabaseHelper().setString('key', 'value');
  print(await KeyValueDatabaseHelper().getString('key'));

  runApp(
      MyApp(themeController: themeController)
  );
}