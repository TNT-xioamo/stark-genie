import 'package:local_notifier/local_notifier.dart';

void _localNot(value) {
  final notification = LocalNotification(
    // 用来生成通用唯一识别码
    identifier: '12345',
    title: '古诗鉴赏从',
    subtitle: '桃夭 - 佚名〔先秦〕',
    body: '桃之夭夭，灼灼其华。之子于归，宜其室家。\n桃之夭夭，有蕡其实。之子于归，宜其家室。\n桃之夭夭，其叶蓁蓁。之子于归，宜其家人。',
    // 用来设置是否静音
    silent: true,
  );
  // notification.onShow = () {
  //   BotToast.showText(text: '显示了一条通知');
  // };
  // notification.onClose = () {
  //   BotToast.showText(text: '通知已经关闭');
  // };
  // notification.onClick = () {
  //   BotToast.showText(text: '通知被点击了');
  // };
  // notification.onClickAction = (index) {
  //   BotToast.showText(text: '你点击了通知的第$index个选项');
  // };
  notification.show();
}
