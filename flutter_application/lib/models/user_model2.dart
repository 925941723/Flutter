
import 'account_model2.dart';

class UserModel2 {
  String name;
  AccountModel2 accountModel2;

  UserModel2({
    required this.name,
    required this.accountModel2,
  });

  factory UserModel2.fromJson(Map<String, dynamic> json) => UserModel2(
    name: json["name"],
    accountModel2: AccountModel2.fromJson(json["accountModel2"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "accountModel2": accountModel2.toJson(),
  };
}