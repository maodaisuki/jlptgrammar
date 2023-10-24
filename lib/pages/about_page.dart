import 'package:flutter/material.dart';
import 'package:jlptgrammar/common/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({
    Key? key,
  }) : super(key: key);
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  void openURL(url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw '无法启动 $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeConfig['backgroundColor'],
      appBar: AppBar(
        title: Text("关于软件", style: TextStyle(color: themeConfig['titleColor'])),
        backgroundColor: themeConfig['themeColor'],
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(
                  context
              );
            },
            color: themeConfig['iconColor'],
          );
        }),
      ),
      body: Container(
        color: themeConfig['backgroundColor'],
        margin: const EdgeInsets.all(0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: Text("开放源代码许可", style: TextStyle(fontSize: 18, color: themeConfig['textColor'])),
                onTap: () {
                  print("开放源代码许可");
                  // Navigator.of(context).pushNamed('/source');
                  Navigator.of(context).push(
                      MaterialPageRoute<void>(
                          builder: (context) => Theme(
                            data: ThemeData(
                                appBarTheme: AppBarTheme(
                                  backgroundColor: themeConfig['themeColor'],
                                  iconTheme: Theme.of(context).iconTheme.copyWith(
                                    color: themeConfig['iconColor'],
                                  ),
                                  titleTextStyle: TextStyle(color: themeConfig['titleColor'], fontSize: 23),
                                ),

                                textTheme: Theme.of(context).textTheme.copyWith(
                                  titleLarge: TextStyle(color: themeConfig['titleColor']),
                                  titleMedium: TextStyle(color: themeConfig['titleColor']),
                                  titleSmall: TextStyle(color: themeConfig['titleColor']),
                                ),
                            ),
                            child: Scaffold(
                              // TODO 夜间模式适配
                              backgroundColor: themeConfig['backgroundColor'],
                              body: LicensePage(
                                applicationName: '日本語文法',
                                applicationVersion: 'v1.0.0',
                                applicationIcon: Container(
                                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                                  child: Image.asset(
                                    'lib/assets/jlptgrammar.png',
                                    height: 80,
                                    width: 80,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ));
                },
                trailing: Icon(Icons.keyboard_arrow_right, color: themeConfig['drawerIconColor']),
              ),
              Divider(
                height: 0.5,
                indent: 0,
                color: themeConfig['lineColor'],
              ),
              ListTile(
                title: Text("数据来源说明", style: TextStyle(fontSize: 18, color: themeConfig['textColor'])),
                onTap: () {
                  print("数据来源说明");
                  Navigator.of(context).pushNamed('/datainfo');
                },
                trailing: Icon(Icons.keyboard_arrow_right, color: themeConfig['drawerIconColor']),
              ),
              Divider(
                height: 0.5,
                indent: 0,
                color: themeConfig['lineColor'],
              ),
              ListTile(
                title: Text("恢复初始设置", style: TextStyle(fontSize: 18, color: /* themeConfig['textColor'] */ Colors.grey)),
                onTap: () async {
                  print("恢复初始设置");
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  // TODO
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('开发中'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                trailing: Icon(Icons.keyboard_arrow_right, color: themeConfig['drawerIconColor']),
              ),
              Divider(
                height: 0.5,
                indent: 0,
                color: themeConfig['lineColor'],
              ),
              ListTile(
                title: Text("Github 仓库", style: TextStyle(fontSize: 18, color: themeConfig['textColor'])),
                onTap: () {
                  // TODO 更好的关于弹窗页面
                  print("Github 仓库");
                  String url = "https://github.com/maodaisuki/jlptgrammar";
                  print("搜索链接: $url");
                  openURL(Uri.parse(url));
                },
                trailing: Icon(Icons.keyboard_arrow_right, color: themeConfig['drawerIconColor']),
              ),
              Divider(
                height: 0.5,
                indent: 0,
                color: themeConfig['lineColor'],
              ),
            ],
          ),
        ),
      ),
    );
  }
}