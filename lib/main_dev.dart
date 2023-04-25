import 'package:get/get.dart';

import 'env.dart';
import 'main_com.dart';

void main() async {
  final buildEnv = BuildEnvironment.dev(
    apiBaseUrl: 'http://172.16.0.19:9001',
  );
  // 放到一个可以全局访问的地方
  Get.put(buildEnv);
  main();
}
