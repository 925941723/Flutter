/// account : ""
/// password : ""

class AccountModel3 {
  AccountModel3({
      this.account, 
      this.password,});

  AccountModel3.fromJson(dynamic json) {
    account = json['account'];
    password = json['password'];
  }
  String? account;
  String? password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['account'] = account;
    map['password'] = password;
    return map;
  }

}