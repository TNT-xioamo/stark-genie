import 'package:dio/dio.dart';
import 'package:stark_genie/dio_util/dio_util.dart';

class DioTokenInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.headers['refreshToken'] == null) {
      DioUtil.getInstance()?.dio.lock();
      Dio _tokenDio = Dio();
      _tokenDio.get("http://172.16.0.19:9001/getRefreshToken").then((d) {
        options.headers['refreshToken'] = d;
        handler.next(options);
      }).catchError((error, StackTrace) {
        handler.reject(error, true);
      }).whenComplete(() {
        DioUtil.getInstance()?.dio.unlock();
      });
    } else {
      options.headers['refreshToken'] = options.headers['refreshToken'];
      handler.next(options);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    // 响应前需要做刷新token 的操作
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }
}
