import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:pokemon/data/state/remote_state.dart';

class DioApiClient {
  //create dio singletone instance
  static final DioApiClient _instance = DioApiClient._internal();
  factory DioApiClient() => _instance;

  late final Dio _dio;
  Dio get dio => _dio;

  DioApiClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://pokeapi.co/api/v2/pokemon',
        connectTimeout: const Duration(milliseconds: 10000),
        receiveTimeout: const Duration(milliseconds: 10000),
        responseType: ResponseType.json,
        contentType: 'application/json',
        headers: {'Accept': 'application/json'},
        validateStatus: (status) => status! >= 200 && status < 400,
        receiveDataWhenStatusError: true,
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Do something before request is sent
          _dioLogRequestHandler(options);
          return handler.next(options); //continue
        },
        onResponse: (response, handler) {
          // Do something with response data
          return handler.next(response); // continue
        },
        onError: (DioException e, handler) {
          // Do something with response error
          _dioErorrHandler(e);
          return handler.next(e); //continue
        },
      ),
    );

    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  _dioLogRequestHandler(RequestOptions options) {
    developer.log(
      'Request => PATH: ${options.path} \n=> METHOD: ${options.method} \n=> DATA: ${options.data}',
    );
  }

  _dioErorrHandler(DioException error) {
    return RemoteStateError('${error.message}');
  }
}
