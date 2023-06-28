import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/kvdb/key_value_database_helper.dart';
import 'package:flutter_application/kvdb/secure_storage_processor.dart';
import 'package:flutter_application/page/app.dart';
import 'package:flutter_application/theme/themes_controller.dart';
import 'package:flutter_application/theme/themes_service.dart';

void main() async {
  // 接入bugly方式
  // flutter_bugly: ^0.4.4
  //  app/build.gradle
  // lintOptions {
  //         // 如打包出现Failed to transform libs.jar to match attributes
  //         checkReleaseBuilds false
  //     }
  //     defaultConfig {
  //         ndk {
  //             // 设置支持的 so 库架构 'armeabi-v7a', 'arm64-v8a', 'x86', 'x86_64'
  //             abiFilters 'armeabi-v7a'
  //         }
  //     }
  // FlutterBugly.postCatchedException(() {
  //   runApp(const MyApp());
  //   FlutterBugly.init(
  //     androidAppId: Constants.androidAppId,
  //   );
  // });

  //错误日志处理包裹
  runZonedGuarded(() async {

    WidgetsFlutterBinding.ensureInitialized();

    //  Flutter 异常捕获
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.dumpErrorToConsole(details);
      if (kReleaseMode) {
        // 错误日志上传1
        //profile,release两个模式下下捕捉异常信息
        // reportFrameworkError(details);
      }
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      // 错误日志上传1
      // If you wish to record a "non-fatal" exception, please remove the "fatal" parameter
      // FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    // 主题
    final themeController = ThemesController(ThemesService());
    await themeController.loadSettings();

    // 平台判断
    if (!kIsWeb) {
      // 非web才可以用Platform判断，否则在web使用Platform函数会报错
      // 此处只可判断原生的情况，web下的安卓跟ios判断需在MyApp的build下使用Theme.of(context).platform
      if (Platform.isAndroid) {
        print('platform android');
      } else if (Platform.isIOS) {
        print('platform android');
      }
    }

    // 键值对数据库
    // if(!kIsWeb && (Platform.isAndroid || Platform.isIOS)){ // 安卓或ios原生
    //   await KeyValueDatabaseHelper().init(MMKVProcessor()); // 只有打包安卓的时候采用mmvk，否则会报错
    // }else{
    //   await KeyValueDatabaseHelper().init(SharedPreferencesProcessor());
    // }
    await KeyValueDatabaseHelper().init(SecureStorageProcessor());
    await KeyValueDatabaseHelper().setString('key', 'value');
    print(await KeyValueDatabaseHelper().getString('key'));

    // 启动
    runApp(MyApp(themeController: themeController));
  },
        (Object error, StackTrace stack) async {
          // 错误日志上传2
      // await FlutterCrashlytics().reportCrash(error, stackTrace, forceCrash: false);
    },
  );

  ;
}
