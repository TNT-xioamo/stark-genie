import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Stark/pages/home_content/home_content.dart';

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
  bool _isState = true;
  bool _isStatus = true;
  String account = '';
  String currentUser = '';

  var prefs = null;

  // @override
  // void initState() {
  //   prefs = SharedPreferences.getInstance();
  //   super.initState();
  // }

  void _onOpenUserFloating(int value) async {
    prefs = await SharedPreferences.getInstance();
    account = prefs.getString('user_phone') ?? '';
    currentUser = prefs.getString('user') ?? '';
    setState(() {
      _isVisible = !_isVisible;
      _isState = !_isState;
    });
  }

  void _onLogout() {
    _onOpenUserFloating(123);
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/StarkLogin',
      (route) => route == null,
    );
  }

  @override
  Widget build(BuildContext context) {
    @override
    Widget userAvatar = Container(
      // 绘制头像
      width: 45,
      height: 45,
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/8debbf5d6b0d43348d89e4c2930592e2~tplv-k3u1fbpfcp-no-mark:320:320:320:320.awebp?',
          ),
          fit: BoxFit.cover,
        ),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.all(
          // 设置图片为圆形
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
        height: 170,
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(20),
        decoration: new BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: new BorderRadius.all(
              const Radius.circular(11.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5), // 阴影的颜色
                offset: Offset(10, 20), // 阴影与容器的距离
                blurRadius: 45.0, // 高斯的标准偏差与盒子的形状卷积。
                spreadRadius: 0.0, // 在应用模糊之前，框应该膨胀的量。
              )
            ]),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(currentUser == '刘星' ? 'Stark' : currentUser),
                ),
                Icon(Icons.account_circle,
                    color: Color.fromARGB(255, 45, 101, 255)),
                Container(
                  margin: const EdgeInsets.only(left: 150),
                  child: userAvatar,
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text('账号:',
                        style: TextStyle(
                          color: Color.fromARGB(255, 114, 114, 114), // 文字颜色
                        )),
                  ),
                  SelectableText(account),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 170),
              child: TextButton(
                onPressed: () => _onLogout(),
                child: Text('退出登录'),
              ),
            )
          ],
        ));

    @override
    Widget userStatus = Container(
        width: 45,
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(0),
        child: Row(
          children: <Widget>[
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  color: _isStatus
                      ? Color.fromARGB(255, 28, 153, 231)
                      : Color.fromARGB(255, 231, 28, 28),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
            ),
            SizedBox(
              width: 5,
            ),
            Text(_isStatus ? '在线' : '离线',
                style: TextStyle(
                  color: _isStatus
                      ? Color.fromARGB(255, 28, 153, 231)
                      : Color.fromARGB(255, 231, 28, 28),
                ))
          ],
        ));

    @override
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
        // margin: EdgeInsets.only(top: 30),
        alignment: Alignment.topCenter,
        decoration:
            const BoxDecoration(color: Color.fromARGB(55, 227, 227, 227)),
        child: Stack(children: <Widget>[
          Container(
            width: 65,
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(top: 30, left: 10),
            decoration: new BoxDecoration(
                color: Color.fromARGB(255, 188, 187, 187),
                borderRadius: new BorderRadius.all(
                  const Radius.circular(11.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.5), // 阴影的颜色
                    offset: Offset(5, 5), // 阴影与容器的距离
                    blurRadius: 35.0, // 高斯的标准偏差与盒子的形状卷积。
                    spreadRadius: 0.0, // 在应用模糊之前，框应该膨胀的量。
                  )
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(children: <Widget>[
                  userAvatar,
                ]),
                Row(children: <Widget>[
                  Transform.translate(
                    offset: Offset(0, 500),
                    child: userStatus,
                  ),
                ]),
              ],
            ),
          ),
          ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  StarkMain(
                    key: ValueKey(''),
                  )
                ],
              )),
          Stack(
            children: [
              Positioned(
                top: 35,
                left: 10,
                child: AnimatedOpacity(
                    opacity: _isVisible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: Visibility(
                      visible: _isVisible,
                      child: Transform.translate(
                        offset: Offset(55.0, -15.0),
                        child: userInfo,
                      ),
                    )),
              )
            ],
          ),
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
