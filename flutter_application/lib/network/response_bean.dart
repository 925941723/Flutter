// 返回原始数据bean
class ResponseBean {
  late int code;
  late String msg;
  late dynamic data;

  ResponseBean(this.code, this.msg, this.data);

  ResponseBean.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['message'];
    data = json['data'];
  }
}
