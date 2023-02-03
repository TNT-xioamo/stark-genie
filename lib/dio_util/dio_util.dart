import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:stark_genie/dio_util/dio_method.dart';
import 'package:stark_genie/dio_util/dio_token_interceptors.dart';
import 'package:stark_genie/dio_util/dio_interceptors.dart';
import 'package:stark_genie/dio_util/dio_transformer.dart';
import 'package:stark_genie/dio_util/dio_cache_interceptors.dart';

class DioUtil {
  ///  链接超时
  static const int CONNECT_TIMEOUT = 6 * 1000;
  // 响应超时
  static const int RECEIVE_TIMEOUT = 6 * 1000;
  // 请求前缀
  // static String BASE_URL = "http://localhonst:8080";
  static String BASE_URL = "http://172.16.0.19:9001";
  // 网络缓存
  static bool CACHE_ENABLE = false;
  // 最大缓存时间 默认7天
  static int MAX_CACHE_AGE = 7 * 24 * 60 * 60;
  // 最大缓存条数
  static int MAX_CACHE_COUNT = 100;

  static DioUtil? _instance;
  static Dio _dio = Dio();

  Dio get dio => _dio;

  DioUtil._internal() {
    _instance = this;
    _instance!._init();
  }

  factory DioUtil() => _instance ?? DioUtil._internal();
  static DioUtil? getInstance() {
    _instance ?? DioUtil._internal();
    return _instance;
  }

  /// 取消请求token
  CancelToken _cancelToken = CancelToken();

  /// cookie
  CookieJar cookieJar = CookieJar();

  _init() {
    // 初始化选项
    BaseOptions options = BaseOptions(
        baseUrl: BASE_URL,
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT);
    // 初始化 dio
    _dio = Dio(options);

    // 添加拦截器
    _dio.interceptors.add(DioInterceptors());

    /// 添加转换器
    _dio.transformer = DioTransformer();

    // 添加cookie 管理器
    _dio.interceptors.add(CookieManager(cookieJar));

    // 刷新token 拦截器(lock/unlock)
    _dio.interceptors.add(DioTokenInterceptors());

    // 添加缓存拦截器
    _dio.interceptors.add(DioCacheInterceptors());
  }

  /// 设置http 代理（开启）
  void setProxy({String? proxyAddress, bool enable = false}) {
    if (enable) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.findProxy = (uri) {
          return proxyAddress ?? "";
        };
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }
  }

  void setHttpsCertificateVerification({String? pem, bool enable = false}) {
    if (enable) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) {
          if (cert.pem == pem) {
            return true;
          }
          return false;
        };
      };
    }
  }

  /// 开启日志打印
  void openLog() {
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  // 请求类
  Future<T> request<T>(
    String path, {
    DioMethod method = DioMethod.get,
    Map<String, dynamic>? params,
    data,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    const _methodValues = {
      DioMethod.get: 'get',
      DioMethod.post: 'post',
      DioMethod.put: 'put',
      DioMethod.delete: 'delete',
      DioMethod.patch: 'patch',
      DioMethod.head: 'head'
    };

    options ??= Options(method: _methodValues[method]);
    try {
      Response response;
      response = await _dio.request(path,
          data: data,
          queryParameters: params,
          cancelToken: cancelToken ?? _cancelToken,
          options: options,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);
      return response.data;
    } on DioError catch (e) {
      throw e;
    }
  }
  
  // 取消网络请求
  void cancelRequests({CancelToken? token}) {
    token ?? _cancelToken.cancel("cancelled");
  }
}
