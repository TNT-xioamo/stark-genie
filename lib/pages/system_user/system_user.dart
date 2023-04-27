import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

class StarkSideways extends StatefulWidget {
  const StarkSideways({Key? key}) : super(key: key);
  @override
  _userPageState createState() => _userPageState();
}

final List<NavigationRailDestination> destinations = const [
  NavigationRailDestination(
      icon: Icon(Icons.message_outlined), label: Text("消息")),
  NavigationRailDestination(
      icon: Icon(Icons.video_camera_back_outlined), label: Text("视频会议")),
  NavigationRailDestination(
      icon: Icon(Icons.book_outlined), label: Text("通讯录")),
  NavigationRailDestination(
      icon: Icon(Icons.cloud_upload_outlined), label: Text("云文档")),
  NavigationRailDestination(icon: Icon(Icons.games_sharp), label: Text("工作台")),
  NavigationRailDestination(icon: Icon(Icons.calendar_month), label: Text("日历"))
];

void _onDestinationSelected(int value) {
  //TODO 更新索引 + 切换界面
}

Widget _buildLeftNavigation(int index) {
  return NavigationRail(
    onDestinationSelected: _onDestinationSelected,
    destinations: destinations,
    selectedIndex: index,
  );
}

class _userPageState extends State<StarkSideways> {
  bool _isVisible = false; //是现实用户信息
  void _onOpenUserFloating(int value) {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 绘制头像
    Widget userAvatar = Container(
      width: 45,
      height: 45,
      alignment: Alignment.topCenter, //  设置图片为圆形
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/8debbf5d6b0d43348d89e4c2930592e2~tplv-k3u1fbpfcp-no-mark:320:320:320:320.awebp?',
          ),
          fit: BoxFit.cover,
        ),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.all(
          const Radius.circular(7.0),
        ),
      ),
      child: InkWell(
        onTap: () => _onOpenUserFloating(123123),
      ),
    );

    @override
    Widget userInfo = Container(
        width: 320,
        height: 150,
        padding: const EdgeInsets.all(10),
        decoration: new BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: new BorderRadius.all(
            const Radius.circular(11.0),
          ),
        ),
        child: Row(
          children: [Text('切换账号')],
        ));

    Widget itemEl = Container(
      // 侧边列表
      width: 165,
      padding: const EdgeInsets.all(10),
      decoration: new BoxDecoration(
        color: Color.fromARGB(255, 211, 211, 211),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[],
      ),
    );

    return Container(
        margin: EdgeInsets.only(top: 30),
        alignment: Alignment.topCenter,
        decoration:
            const BoxDecoration(color: Color.fromARGB(55, 227, 227, 227)),
        child: Row(children: <Widget>[
          Container(
            width: 65,
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(10),
            decoration: new BoxDecoration(
              color: Color.fromARGB(255, 188, 187, 187),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(children: <Widget>[
                  userAvatar,
                ]),
              ],
            ),
          ),
          Visibility(
            visible: _isVisible,
            child: userInfo,
          )
        ]));
  }
}
// AnimatedOpacity(
//             opacity: _isVisible ? 1.0 : 0.0,
//             duration: const Duration(milliseconds: 500),
//             child: userInfo,
//           )

// NDialog(
//     dialogStyle: DialogStyle(titleDivider: true),
//     title: Text("NDialog"),
//     content: Text("This is NDialog's content"),
//     actions: <Widget>[
//       TextButton(child: Text("Okay"), onPressed: () => Navigator.pop(context)),
//       TextButton(child: Text("Close"), onPressed: () => Navigator.pop(context)),
//     ],
//   ).show(context);
