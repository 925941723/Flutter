import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_application/data/source/remote/network_exception.dart';
import 'package:flutter_application/data/source/remote/response_bean.dart';

// 持久层拦截器
class PersistentInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // options.headers['Authorization'] = 'Bearer 123';
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    ResponseBean responseBean = ResponseBean.fromJson(response.data);
    if(responseBean.code == 0){
      response.data = responseBean.data;
    }else{
      throw(
          DioException(
            type: DioExceptionType.badResponse,
            message: responseBean.msg,
            requestOptions: response.requestOptions,
            response: response,
            error: null,
          )
      );
      // throw(DioException.badResponse(statusCode: response.statusCode!, requestOptions: response.requestOptions, response: response));
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(NetworkException.create(err), handler);
  }

}