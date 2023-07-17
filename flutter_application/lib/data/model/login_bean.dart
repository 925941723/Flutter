// To parse this JSON data, do
//
//     final loginBean = loginBeanFromJson(jsonString);

class LoginBean {
  String accessToken;
  int expiresIn;
  String model;
  String openid;
  String refreshToken;
  String scope;
  String tokenType;

  LoginBean({
    required this.accessToken,
    required this.expiresIn,
    required this.model,
    required this.openid,
    required this.refreshToken,
    required this.scope,
    required this.tokenType,
  });

  factory LoginBean.fromJson(Map<String, dynamic> json) => LoginBean(
    accessToken: json["access_token"],
    expiresIn: json["expires_in"],
    model: json["model"],
    openid: json["openid"],
    refreshToken: json["refresh_token"],
    scope: json["scope"],
    tokenType: json["token_type"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "expires_in": expiresIn,
    "model": model,
    "openid": openid,
    "refresh_token": refreshToken,
    "scope": scope,
    "token_type": tokenType,
  };
}