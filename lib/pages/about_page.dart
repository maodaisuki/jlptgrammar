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
        // title: Text("关于软件", style: TextStyle(color: themeConfig['titleColor'])),
        backgroundColor: themeConfig['backgroundColor'],
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(
                context
              );
            },
            color: themeConfig['drawerIconColor'],
          );
        }),
      ),
      body: Container(
        margin: const EdgeInsets.all(0),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Image.asset(
                          'lib/assets/jlptgrammar.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Center(
                      child: Text('日本語文法', style: TextStyle(color: themeConfig['textColor'], fontSize: 20, fontWeight: FontWeight.w700)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Center(
                      child: Text("Version ${packageInfo.version} -release", style: TextStyle(color: themeConfig['textColor'], fontSize: 16)),
                    ),
                  ),
                  ListTile(
                    leading: Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Icon(Icons.emoji_emotions, color: themeConfig['drawerIconColor']),
                    ),
                    title: Text('日本語文法官方网站', style: TextStyle(fontSize: 20, color: themeConfig['textColor'])),
                    subtitle: Text('软件官方网站', style: TextStyle(fontSize: 14, color: themeConfig['textColor'])),
                    minVerticalPadding: 10,
                    onTap: () {
                      print("打开官网");
                      openURL(Uri.parse('https://github.com/maodaisuki/jlptgrammar/'));
                    },
                  ),
                  ListTile(
                    leading: Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Icon(Icons.sticky_note_2_outlined, color: themeConfig['drawerIconColor']),
                    ),
                    title: Text('日本語 NET 官方网站', style: TextStyle(fontSize: 20, color: themeConfig['textColor'])),
                    subtitle: Text('提供了软件所使用的语法数据', style: TextStyle(fontSize: 14, color: themeConfig['textColor'])),
                    minVerticalPadding: 10,
                    onTap: () {
                      print("打开官网");
                      openURL(Uri.parse('https://nihongokyoshi-net.com/jlpt-grammars/'));
                    },
                  ),
                  ListTile(
                    leading: Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Icon(Icons.rocket_launch, color: themeConfig['drawerIconColor']),
                    ),
                    title: Text('检查更新', style: TextStyle(fontSize: 20, color: themeConfig['textColor'])),
                    subtitle: Text('检查 Github 仓库有无新版本发布', style: TextStyle(fontSize: 14, color: themeConfig['textColor'])),
                    minVerticalPadding: 10,
                    onTap: () {
                      // TODO 抓取通用版本，提示小体积版本
                    },
                  ),
                  // TODO 添加开源相关
                  // ListTile(
                  //   leading: Container(
                  //     margin: EdgeInsets.only(left: 15),
                  //     child: Icon(Icons.rocket_launch, color: themeConfig['drawerIconColor']),
                  //   ),
                  //   title: Text('开源相关', style: TextStyle(fontSize: 20, color: themeConfig['textColor'])),
                  //   subtitle: Text('', style: TextStyle(fontSize: 14, color: themeConfig['textColor'])),
                  //   minVerticalPadding: 10,
                  //   onTap: () {
                  //
                  //   },
                  // ),
                ],
              ),
            ),
        ),
      ),
    );
  }
}