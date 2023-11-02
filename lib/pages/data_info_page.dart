import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jlptgrammar/common/global.dart';
import 'package:url_launcher/url_launcher.dart';

class DataInfoPage extends StatefulWidget {
  const DataInfoPage({
    Key? key,
  }) : super(key: key);
  @override
  _DataInfoPageState createState() => _DataInfoPageState();
}

class _DataInfoPageState extends State<DataInfoPage> {
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
        title: Text("数据来源说明", style: TextStyle(color: themeConfig['titleColor'])),
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
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(
              //   child: Image.asset(
              //     'lib/assets/site.png',
              //     fit: BoxFit.fitWidth,
              //   ),
              // ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.only(left: 0, right: 0, bottom: 5),
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    text: '本软件初始内容所有语法体条目及及其详细内容均来自网站',
                    style: TextStyle(color: themeConfig['textColor'], fontSize: 18, height: 1.5),
                    children: <TextSpan>[
                      TextSpan(
                        text: '毎日のんびり日本語教師',
                        style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          height: 1.5
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            String url = "https://nihongonosensei.net/";
                            print("搜索链接: $url");
                            openURL(Uri.parse(url));
                            print('超链接！');
                          },
                      ),
                      const TextSpan(
                        text: '。\n\n相关内容版权声明: \nCopyright \u00a9 毎日のんびり日本語教師 All Rights Reserved.\n\n相关链接:\n',
                      ),
                      const TextSpan(
                        text: '1. '
                      ),
                      TextSpan(
                        text: '毎日のんびり日本語教師\n',
                        style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            String url = "https://nihongonosensei.net/";
                            print("搜索链接: $url");
                            openURL(Uri.parse(url));
                            print('超链接！');
                          },
                      ),
                      const TextSpan(
                          text: '2. '
                      ),
                      TextSpan(
                        text: '语法条目页面',
                        style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            String url = "https://nihongonosensei.net/?page_id=10246";
                            print("搜索链接: $url");
                            openURL(Uri.parse(url));
                            print('超链接！');
                          },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}