import 'package:flutter_application/models/account_model3.dart';

class UserModel3 {
  UserModel3({
      this.name, 
      this.accountModel3,});

  UserModel3.fromJson(dynamic json) {
    name = json['name'];
    accountModel3 = AccountModel3.fromJson(json['accountModel3']);
  }
  String? name;
  AccountModel3? accountModel3;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['accountModel3'] = accountModel3?.toJson();
    return map;
  }

}