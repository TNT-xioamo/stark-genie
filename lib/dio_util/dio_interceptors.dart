import 'package:dio/dio.dart';
import 'package:stark_genie/dio_util/dio_response.dart';

class DioInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 对非open的接口的请求参数全部增加userId
    if (!options.path.contains("open")) {
      options.queryParameters["userId"] = "xxx";
    }

    //  头部添加
    options.headers["token"] = "xxx";
    // 更多需求
    handler.next(options);
    // super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    // 请求成功是对数据做基本处理
    if (response.statusCode == 200) {
      response.data =
          DioResponse(code: 0, message: "请求成功啦", data: response.data);
    } else {
      response.data =
          DioResponse(code: 1, message: "请求失败啦", data: response.data);
    }
    // 对某些单独的url返回数据做特殊处理
    if (response.requestOptions.baseUrl.contains("???????")) {
      //....
    }

    // 根据需求定制化处理

    // 注意
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      // 连接服务器超时
      case DioErrorType.connectTimeout:
        {
          // …… ……
        }
        break;
      // 响应超时
      case DioErrorType.receiveTimeout:
        {}
        break;
      // 发送超时
       case DioErrorType.sendTimeout:
        {
          // 根据自己的业务需求来设定该如何操作,可以是弹出框提示/或者做一些路由跳转处理
        }
        break;
      // 请求取消
      case DioErrorType.cancel:
        {
          // 根据自己的业务需求来设定该如何操作,可以是弹出框提示/或者做一些路由跳转处理
        }
        break;
        //  404/503错误
      case DioErrorType.response:
        {
          // 根据自己的业务需求来设定该如何操作,可以是弹出框提示/或者做一些路由跳转处理
        }
        break;
      // other 其他错误类型
       case DioErrorType.other:
        {

        }
        break;
      default:
    }
    super.onError(err, handler);
  }
}
