class DioResponse<T> {
  // 消息（成功与失败的消息）
  final String message;
  // 自定义code
  final int code;
  final T data;
  // 添加自定义

  DioResponse({
    required this.message,
    required this.data,
    required this.code,
  });

  String toString() {
    StringBuffer sb = StringBuffer('{');
    sb.write("\"messge\":\"$message\"");
    sb.write(",\"errorMsg\":\"$code\"");
    sb.write(",\"data:\"$data\"");
    sb.write('}');
    return sb.toString();
  }
}

class DioResponseCode {
  // 成功
  static const int SUCCESS = 0;
  // 失败
  static const int ERROR = 1;
  // 更多
}
