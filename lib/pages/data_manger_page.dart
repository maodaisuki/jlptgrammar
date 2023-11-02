import 'dart:io';

import 'package:file_picker/file_picker.dart';
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

  Future<void> showExportInfo(String selectedDirectory) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: themeConfig['backgroundColor'],
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))
        ),
        title: Text("导出数据", style: TextStyle(color: themeConfig['textColor'])),
        content: Text("成功导出数据到 $selectedDirectory", style: TextStyle(fontSize: 18, color: themeConfig['textColor'])),
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

  Future<void> showImportOkInfo() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('导入成功～'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> showImportErrorInfo() async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: themeConfig['backgroundColor'],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4))
        ),
        title: Text("导入数据", style: TextStyle(color: themeConfig['textColor'])),
        content: Text("导入失败，请确保文件后缀为 db 且数据库表名、字段合规", style: TextStyle(fontSize: 18, color: themeConfig['textColor'])),
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


  Future<void> showImportInfo() async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: themeConfig['backgroundColor'],
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4))
          ),
          title: Text("导入数据", style: TextStyle(color: themeConfig['textColor'])),
          content: Text("导入前请确保数据文件为 db 数据库文件且其中包含名为 jlptgrammar 的表，其字段包含 'id, level, name, grammar, mean, example, notes.'", style: TextStyle(fontSize: 18, color: themeConfig['textColor'])),
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
                  onTap: () async {
                    await showImportInfo();
                    if(await requestStoragePermission()) {
                      FilePickerResult? result = await FilePicker.platform.pickFiles(
                        allowMultiple: false,
                        // TODO File_Picker 暂时不支持筛选 db 文件
                        // type: FileType.custom,
                        // allowedExtensions: ['db'],
                        // 只挑选 db 文件
                      );
                      if (result != null) {
                        String importPath = result.files.single.path!;
                        if(await grammar.databaseHelper.importDatabase(importPath)) {
                          print("导入成功");
                          showImportOkInfo();
                        }
                        else {
                          print("导入失败");
                          showImportErrorInfo();
                        }
                      }
                      else {
                        print("用户取消了选择");
                      }
                    }
                    else {
                      print("没有存储权限");
                    }
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
                    if(await requestStoragePermission()) {
                      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
                      if(selectedDirectory != null) {
                        if(await grammar.databaseHelper.exportDatabase(selectedDirectory)) {
                          await showExportInfo(selectedDirectory);
                          print("导出成功");
                        }
                        else {
                          print("导出失败");
                        }
                      }
                      else {
                        print("用户取消选择");
                      }
                    }
                    else {
                      print("没有存储权限");
                    }
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
                        // 重载返回键防止中断重置界面
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
                                      child: const Text('确认', style: TextStyle(color: Colors.red, fontSize: 18)),
                                      onPressed: () async {
                                        state(() {
                                          isConfirmed = !isConfirmed;
                                        });
                                        await grammar.databaseHelper.resetDb();
                                        grammar = Grammar();
                                        // 延时 1 秒
                                        await Future.delayed(Duration(seconds: 1), () {
                                          Navigator.pop(context);}
                                        );
                                      }
                                    ),
                                    MaterialButton(
                                      child: Text(
                                        '取消', style: TextStyle(color: themeConfig['textColor'], fontSize: 18)),
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