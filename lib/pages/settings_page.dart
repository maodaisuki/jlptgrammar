import 'package:flutter/material.dart';
import 'package:jlptgrammar/common/global.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    Key? key,
  }) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      // g 用来刷新夜间模式界面
      valueListenable: g,
      builder: (BuildContext context, int value, Widget? child) {
        return Scaffold(
          backgroundColor: themeConfig['backgroundColor'],
          appBar: AppBar(
            title: Text("设置", style: TextStyle(color: themeConfig['titleColor'])),
            backgroundColor: themeConfig['themeColor'],
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(
                  context
                );
              },
              color: themeConfig['iconColor'],
            ),
          ),
          body: Container(
            margin: const EdgeInsets.all(0),
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    ListTile(
                      leading: Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Icon(Icons.rocket_launch, color: themeConfig['drawerIconColor']),
                      ),
                      title: Text('检查更新', style: TextStyle(fontSize: 20, color: themeConfig['textColor'])),
                      subtitle: Text('检查 Github 仓库有无新版本发布', style: TextStyle(fontSize: 14, color: themeConfig['textColor'])),
                      minVerticalPadding: 10,
                      onTap: () {

                      },
                    ),
                    ListTile(
                      leading: Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Icon(Icons.color_lens, color: themeConfig['drawerIconColor']),
                      ),
                      title: Text('显示', style: TextStyle(fontSize: 20, color: themeConfig['textColor'])),
                      subtitle: Text('切换主题颜色', style: TextStyle(fontSize: 14, color: themeConfig['textColor'])),
                      minVerticalPadding: 10,
                      onTap: () {

                      },
                    ),
                    // TODO 语言切换
                    // ListTile(
                    //   leading: Container(
                    //     margin: EdgeInsets.only(left: 15),
                    //     child: Icon(Icons.language, color: themeConfig['drawerIconColor']),
                    //   ),
                    //   title: Text('语言设置', style: TextStyle(fontSize: 20, color: themeConfig['textColor'])),
                    //   subtitle: Text('设置菜单显示语言', style: TextStyle(fontSize: 14, color: themeConfig['textColor'])),
                    //   minVerticalPadding: 10,
                    //   onTap: () {
                    //
                    //   },
                    // ),
                    ListTile(
                      leading: Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Icon(Icons.data_object, color: themeConfig['drawerIconColor']),
                      ),
                      title: Text('数据管理', style: TextStyle(fontSize: 20, color: themeConfig['textColor'])),
                      subtitle: Text('管理软件数据内容', style: TextStyle(fontSize: 14, color: themeConfig['textColor'])),
                      minVerticalPadding: 10,
                      onTap: () {

                      },
                    ),
                    ListTile(
                      leading: Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Icon(Icons.info, color: themeConfig['drawerIconColor']),
                      ),
                      title: Text('关于软件', style: TextStyle(fontSize: 20, color: themeConfig['textColor'])),
                      subtitle: Text('软件相关信息', style: TextStyle(fontSize: 14, color: themeConfig['textColor'])),
                      minVerticalPadding: 10,
                      onTap: () {

                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}