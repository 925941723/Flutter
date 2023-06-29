import 'package:flutter/material.dart';
import 'package:flutter_application/models/account_model.dart';
import 'package:flutter_application/models/account_model2.dart';
import 'package:flutter_application/models/account_model3.dart';
import 'package:flutter_application/models/user_model.dart';
import 'package:flutter_application/models/user_model2.dart';
import 'package:flutter_application/models/user_model3.dart';


/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class ModelToJsonPage extends StatelessWidget {
  const ModelToJsonPage({super.key});

  static const routeName = '/modelToJsonPage';


  @override
  Widget build(BuildContext context) {
    // JSON和序列化数据  官方方式 https://flutter.cn/docs/data-and-backend/json
    // 缺点：会生成额外的文件
    AccountModel accountModel = AccountModel('account', 'password');
    UserModel userModel = UserModel('name', accountModel);
    // print('userModel:${userModel.toJson()}');
    // 使用网页转换方式 https://app.quicktype.io/
    // 缺点：嵌套的时候需要手动建多个文件，只有在生成非空的实体类时比较好用
    AccountModel2 accountModel2 = AccountModel2(account: 'account', password: 'password');
    UserModel2 userModel2 = UserModel2(name: 'name',accountModel2: accountModel2);
    // print('userModel2:${userModel2.toJson()}');
    // 使用Plugins安装JsonToDart，右键models文件夹，选new，选JsonToDart。在弹窗的setting勾上null-safety，其他全不勾。然后输入json字符串，输入名字，点生成
    // 缺点：只有在生成空安全(即可以为空)的实体类比较好用
    AccountModel3 accountModel3 = AccountModel3(account: 'account', password: 'password');
    UserModel3 userModel3 = UserModel3(name: 'name',accountModel3: accountModel3);
    // print('userModel3:${userModel3.toJson()}');
    /// 推荐:
    /// 本地实体使用第2种方式
    /// 请求返回使用第3种方式，对于不可空的属性设置成required，并去掉问号、加入late

    return Scaffold(
      appBar: AppBar(
        title: Text('模块与json转换'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // const Text(
              //   'You have pushed the button this many times:',
              // ),
              Text(userModel.toJson().toString()),
              Text(userModel2.toJson().toString()),
              Text(userModel3.toJson().toString()),
            ],
          ),
        ),
      ),
    );
  }
}
