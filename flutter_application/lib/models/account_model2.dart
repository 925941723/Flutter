class AccountModel2 {
  String account;
  String password;

  AccountModel2({
    required this.account,
    required this.password,
  });

  factory AccountModel2.fromJson(Map<String, dynamic> json) => AccountModel2(
    account: json["account"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "account": account,
    "password": password,
  };
}
