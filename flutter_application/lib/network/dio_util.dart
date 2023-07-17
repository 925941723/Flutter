import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter_application/data/source/remote/persistent_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'interceptor/dio_logger_error_interceptor.dart';
import 'interceptor/dio_logger_request_interceptor.dart';
import 'interceptor/dio_logger_response_interceptor.dart';

// dio工具类
class DioUtil {
  static final Map<String, Dio> _dioMap = {};

  // 享元模式获取，共享dio防止重复创建
  static Dio getDio(String baseUrl, { List<Interceptor> interceptors = const <Interceptor>[] }){
    if(!_dioMap.containsKey(baseUrl)){
      BaseOptions baseOptions = BaseOptions(
        baseUrl: baseUrl
      );
      var dio = Dio(baseOptions);
        // RetryInterceptor( // 重试拦截器
        //   dio: dio,
        //   logPrint: print,
        //   retries: 3, // 重试3次
        //   retryDelays: const [
        //     Duration(seconds: 1), // 每次的间隔时间
        //     Duration(seconds: 3),
        //     Duration(seconds: 5),
        //   ]
        // )
      // 返回日志拦截器放最开头，以便拿到最原始数据
      dio.interceptors.add(DioLoggerResponseInterceptor(
        responseBody: true,
        responseHeader: false,
      ));
      interceptors.forEach((element) {
        dio.interceptors.add(element);
      });
      // 请求日志拦截器需要放到PersistentInterceptor之后，这样可以打印出header
      dio.interceptors
        ..add(DioLoggerRequestInterceptor(
        requestHeader: true,
        requestBody: true,
        ))
        // 请求日志拦截器
        ..add(DioLoggerErrorInterceptor(
          error: true,
        ));
      // dio.interceptors.add(PrettyDioLogger(
      //   requestHeader: true,
      //   requestBody: true,
      //   responseBody: true,
      //   responseHeader: true,
      //   error: true,
      //   compact: true,
      // )); // log拦截器
      _dioMap[baseUrl] = dio;
    }
    return _dioMap[baseUrl]!;
  }
}