import 'package:flutter/material.dart';
import 'package:jlptgrammar/common/global.dart';
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
      appBar: AppBar(
        title: Text("关于软件", style: TextStyle(color: titleColors[0])),
        backgroundColor: Colors.deepPurple,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(
                  context
              );
            },
            color: Colors.white,
          );
        }),
      ),
      body: Container(
        color: Colors.white,
        margin: const EdgeInsets.all(0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: const Text("开放源代码许可", style: TextStyle(fontSize: 18)),
                onTap: () {
                  print("开放源代码许可");
                  // Navigator.of(context).pushNamed('/source');
                  Navigator.of(context).push(
                      MaterialPageRoute<void>(
                          builder: (context) => Theme(
                            data: ThemeData(
                                appBarTheme: AppBarTheme(
                                  backgroundColor: themes[0],
                                  iconTheme: Theme.of(context).iconTheme.copyWith(
                                    color: iconColors[0],
                                  ),
                                  titleTextStyle: TextStyle(color: titleColors[0], fontSize: 23),
                                ),

                                textTheme: Theme.of(context).textTheme.copyWith(
                                  titleLarge: TextStyle(color: titleColors[0]),
                                  titleMedium: TextStyle(color: titleColors[0]),
                                  titleSmall: TextStyle(color: titleColors[0]),
                                ),
                            ),
                            child: LicensePage(
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
                  ));
                },
                trailing: const Icon(Icons.keyboard_arrow_right),
              ),
              const Divider(
                height: 0.5,
                indent: 0,
                color: Colors.black12,
              ),
              ListTile(
                title: const Text("数据来源说明", style: TextStyle(fontSize: 18)),
                onTap: () {
                  print("数据来源说明");
                  Navigator.of(context).pushNamed('/datainfo');
                },
                trailing: const Icon(Icons.keyboard_arrow_right),
              ),
              const Divider(
                height: 0.5,
                indent: 0,
                color: Colors.black12,
              ),
              ListTile(
                title: const Text("恢复初始设置", style: TextStyle(fontSize: 18)),
                onTap: () {
                  print("恢复初始设置");
                },
                trailing: const Icon(Icons.keyboard_arrow_right),
                enabled: false,
              ),
              const Divider(
                height: 0.5,
                indent: 0,
                color: Colors.black12,
              ),
              ListTile(
                title: const Text("Github 仓库", style: TextStyle(fontSize: 18)),
                onTap: () {
                  // TODO 更好的关于弹窗页面
                  print("Github 仓库");
                  String url = "https://github.com/maodaisuki/jlptgrammar";
                  print("搜索链接: $url");
                  openURL(Uri.parse(url));
                },
                trailing: const Icon(Icons.keyboard_arrow_right),
              ),
              const Divider(
                height: 0.5,
                indent: 0,
                color: Colors.black12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}