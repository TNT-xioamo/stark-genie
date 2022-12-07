

import 'package:get/get.dart';

import 'env.dart';
import 'main_com.dart';

void main() async {
  final buildEnv = BuildEnvironment.release(
    apiBaseUrl: 'https://domain.release/api',
  );
  // 1. 放到一个可以全局访问的地方
  Get.put(buildEnv);
  main();
}