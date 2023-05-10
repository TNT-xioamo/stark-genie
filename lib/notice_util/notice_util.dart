import 'package:local_notifier/local_notifier.dart';

void _localNot(msg) {
  final notification = LocalNotification(
    identifier: msg['userId'], // 用来生成通用唯一识别码
    title: msg['title'],
    subtitle: msg['subtitle'],
    body: msg['body'],
    silent: msg['silent'], // 用来设置是否静音
  );
  notification.onShow = () {};
  notification.onClose = (even) {};
  notification.onClick = () {};
  notification.onClickAction = (index) {};
  notification.show();
}
