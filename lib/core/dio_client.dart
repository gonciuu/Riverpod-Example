import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_client.g.dart';

@Riverpod(keepAlive: true)
Dio dio(DioRef ref) {
  final Dio dio = Dio(BaseOptions(
    baseUrl: "https://jsonplaceholder.typicode.com",
    contentType: Headers.jsonContentType,
    headers: <String, String>{
      Headers.acceptHeader: Headers.jsonContentType,
      Headers.contentTypeHeader: Headers.jsonContentType,
    },
  ));

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      debugPrint("REQUEST[${options.method}] => PATH: ${options.path}");
      return handler.next(options);
    },
  ));

  return dio;
}
