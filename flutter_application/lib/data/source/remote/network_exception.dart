import 'dart:io';

import 'package:dio/dio.dart';

// 错误日志转换，将Dio的错误转成我们可以直接toast的日志
class NetworkException extends DioException{
  final String _message;
  final int _code;

  int get code{
    return _code;
  }

  String get message{
    return _message;
  }

  NetworkException(this._code,this._message,{required super.requestOptions, });

  @override
  String toString() {
    return "$_code : $_message";
  }

  factory NetworkException.create(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:{
        return NetworkException(-1, "请求取消", requestOptions: error.requestOptions);
      }
      case DioExceptionType.connectionTimeout:{
        return NetworkException(-1, "网络请求失败,请检查", requestOptions: error.requestOptions);
      }
      case DioExceptionType.sendTimeout:{
        return NetworkException(-1, "网络请求超时,请检查", requestOptions: error.requestOptions);
      }
      case DioExceptionType.receiveTimeout:{
        return NetworkException(-1, "网络接收超时,请检查", requestOptions: error.requestOptions);
      }
      case DioExceptionType.connectionError:{
        return NetworkException(-1, "网络链接错误，请检查", requestOptions: error.requestOptions);
      }
      case DioExceptionType.badCertificate:{
        return NetworkException(-1, "验证失败", requestOptions: error.requestOptions);
      }
      case DioExceptionType.receiveTimeout:{
        return NetworkException(-1, "服务器响应超时", requestOptions: error.requestOptions);
      }
      case DioExceptionType.badResponse:{
        try{
          if(error.response!.statusCode != 200) {
            return NetworkException(error.response!.statusCode!,
                "HTTP ${error.response!.statusCode!}:服务器错误",
                requestOptions: error.requestOptions);
          }else{
            return NetworkException(error.response!.statusCode!,
                error.message ?? '',
                requestOptions: error.requestOptions);
          }
        } catch (_) {
          return NetworkException(-1, "数据异常:${error.error.toString()}", requestOptions: error.requestOptions);
        }
      }
      case DioExceptionType.unknown:{
        return NetworkException(-1, error.error.toString(), requestOptions: error.requestOptions);
      }
      default:{
        return NetworkException(-1, error.error.toString(), requestOptions: error.requestOptions);
      }
    }
  }
}