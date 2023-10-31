import 'package:flutter/material.dart';
import 'package:jlptgrammar/common/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jlptgrammar/common/theme.dart';

import '../utils/permission_tool.dart';

class DataMangerPage extends StatefulWidget {
  const DataMangerPage({
    Key? key,
  }) : super(key: key);
  @override
  _DataMangerPageState createState() => _DataMangerPageState();
}

class _DataMangerPageState extends State<DataMangerPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeConfig['backgroundColor'],
      appBar: AppBar(
        title: Text("数据管理", style: TextStyle(color: themeConfig['titleColor'])),
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
                    child: Icon(Icons.file_copy, color: themeConfig['drawerIconColor']),
                  ),
                  title: Text('导入数据', style: TextStyle(fontSize: 20, color: themeConfig['textColor'])),
                  subtitle: Text('从外部数据库 (.db) 导入数据', style: TextStyle(fontSize: 14, color: themeConfig['textColor'])),
                  minVerticalPadding: 10,
                  onTap: () {

                  },
                ),
                ListTile(
                  leading: Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Icon(Icons.outbox, color: themeConfig['drawerIconColor']),
                  ),
                  title: Text('导出数据', style: TextStyle(fontSize: 20, color: themeConfig['textColor'])),
                  subtitle: Text('将数据导出为数据库 (.db) 文件', style: TextStyle(fontSize: 14, color: themeConfig['textColor'])),
                  minVerticalPadding: 10,
                  onTap: () async {
                    // TODO 考虑边界情况
                    await grammar.databaseHelper.exportDatabase();
                  },
                ),
                ListTile(
                  leading: Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Icon(Icons.refresh, color: themeConfig['drawerIconColor']),
                  ),
                  title: Text('重置数据', style: TextStyle(fontSize: 20, color: themeConfig['textColor'])),
                  subtitle: Text('将数据恢复至初始状态', style: TextStyle(fontSize: 14, color: themeConfig['textColor'])),
                  minVerticalPadding: 10,
                  onTap: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        bool isConfirmed = false;
                        return WillPopScope(
                          onWillPop: () async {
                            if(isConfirmed) {
                              return Future.value(false); // 阻止对话框被关闭
                            }
                            else {
                              return Future.value(true);
                            }
                          },
                          child: StatefulBuilder(
                            builder: (context, state) {
                              return AlertDialog(
                                backgroundColor: themeConfig['backgroundColor'],
                                title: Text("重置数据", style: TextStyle(color: themeConfig['textColor'])),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(4))
                                ),
                                content: isConfirmed == false
                                  ? Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: Text("确认重置数据？", style: TextStyle(fontSize: 18, color: themeConfig['textColor']))
                                    )
                                  : Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: SizedBox(
                                        height: 5,
                                        child: LinearProgressIndicator(color: isLightTheme ? themeConfig['themeColor'] : themeConfig['titleColor']),
                                      )
                                  ),
                                actions: isConfirmed == false
                                  ? <Widget>[
                                    MaterialButton(
                                      child: const Text('确认', style: TextStyle(color: Colors.red, fontSize: 15)),
                                      onPressed: () async {
                                        state(() {
                                          isConfirmed = !isConfirmed;
                                        });
                                        await grammar.databaseHelper.resetDb();
                                        await grammar.init().then((_) async {
                                          // 重置
                                          // 1 防止一直刷新
                                          g.value = (g.value + 1) == 0 ? 1 : (g.value + 1);
                                        });
                                        // 延时 1 秒
                                        await Future.delayed(Duration(seconds: 1), () {
                                          Navigator.pop(context);}
                                        );
                                      }
                                    ),
                                    MaterialButton(
                                      child: Text(
                                        '取消', style: TextStyle(color: themeConfig['textColor'], fontSize: 15)),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    )
                                  ]
                                  : <Widget>[],
                              );
                            }
                          ),
                        );
                      }
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}