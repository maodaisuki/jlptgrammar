import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jlptgrammar/common/global.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class AboutPage extends StatefulWidget {
  const AboutPage({
    Key? key,
  }) : super(key: key);
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String updateInfo = "";
  Map resInfo = {};

  void openURL(url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw '无法启动 $url';
    }
  }

  void showCheckingInfo() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('正在检查～'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  Future<String> getDownloadUrl(Map maps) async {
    String url = "";
    for(var m in maps['assets']) {
      if(m['name'] == 'app-release.apk') {
        // print(m['browser_download_url']);
        return m['browser_download_url'];
      }
    }
    return url;
  }

  Future<bool> compareVersion(String version, String newVersion) async {
    List<int> parts1 = version.split('.').map(int.parse).toList();
    List<int> parts2 = newVersion.split('.').map(int.parse).toList();

    int length = parts1.length < parts2.length ? parts1.length : parts2.length;
    // 暂不考虑版本号长度不一致
    int compareResult = 0;
    for (int i = 0; i < length; i++) {
      if (parts1[i] < parts2[i]) {
        compareResult = -1;
        break;
      } else if (parts1[i] > parts2[i]) {
        compareResult = 1;
        break;
      }
    }
    if(compareResult >= 0) {
      return false;
    }
    else {
      return true;
    }
  }

  Future<bool> checkUpdate(String version) async {
    final response = await http.get(Uri.parse('https://api.github.com/repos/maodaisuki/jlptgrammar/releases/latest'));

    if (response.statusCode == 200) {
      final release = jsonDecode(response.body);
      final newVersion = release['tag_name'].substring(1);
      print("newVersion: $newVersion");
      if(await compareVersion(version, newVersion)) {
        // 有新版本
        updateInfo = release['body'];
        resInfo = release;
        // print(resInfo['assets'][0]['browser_download_url']);
        return true;
      }
      else {
        return false;
      }
    }
    return false;
  }



  Future<void> showUpdateInfo(bool info) async {
    ValueNotifier<int> downloadListener = ValueNotifier<int>(0);
    if(info) {
      // 有新版本
      bool isConfirmDownload = false;
      await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return ValueListenableBuilder(
                valueListenable: downloadListener,
                builder: (BuildContext context, int value, Widget? child) {
                  return AlertDialog(
                    backgroundColor: themeConfig['backgroundColor'],
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))
                    ),
                    title: Text(isConfirmDownload == false ? "发现新版本" : "下载中", style: TextStyle(color: themeConfig['textColor'])),
                    content: isConfirmDownload == false ? Text("$updateInfo\n\n立即更新？", style: TextStyle(fontSize: 18, color: themeConfig['textColor']))
                      : Container(
                        child:
                          LinearProgressIndicator(color: isLightTheme ? themeConfig['themeColor'] : themeConfig['titleColor']),
                    ),
                    actions: <Widget>[
                      MaterialButton(
                          child: Text('取消', style: TextStyle(color: themeConfig['textColor'], fontSize: 18)),
                          onPressed: () async {
                            if(isConfirmDownload) {
                              // 停止下载同时关闭

                              isConfirmDownload = !isConfirmDownload;
                            }
                            Navigator.pop(context);
                          }
                      ),
                      Visibility(
                        visible: !isConfirmDownload,
                        child: MaterialButton(
                          child: const Text('确认', style: TextStyle(color: Colors.red, fontSize: 18,)),
                          onPressed: () async {
                            // 开始下载
                            String url = await getDownloadUrl(resInfo);
                            String savePath = (await getTemporaryDirectory()).path;
                            String apkPath = "$savePath/app-release.apk";
                            setState(() {
                              isConfirmDownload = true;
                              downloadListener.value = 1;
                            });

                            print(url);

                            Navigator.pop(context);
                          }
                        ),
                      ),
                    ],
                );
            });
          }
      );
    }
    else {
      // 没有新版本
      await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => AlertDialog(
            backgroundColor: themeConfig['backgroundColor'],
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4))
            ),
            title: Text("检查更新", style: TextStyle(color: themeConfig['textColor'])),
            content: Text("暂未发现新版本", style: TextStyle(fontSize: 18, color: themeConfig['textColor'])),
            actions: <Widget>[
              MaterialButton(
                  child: Text('确认', style: TextStyle(color: themeConfig['textColor'], fontSize: 18)),
                  onPressed: () async {
                    Navigator.pop(context);
                  }
              ),
            ],
          )
      );
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
                    onTap: () async {
                      // 显示正在检查
                      showCheckingInfo();
                      await showUpdateInfo(await checkUpdate("1.0.0"));
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