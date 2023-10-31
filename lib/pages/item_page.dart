import 'package:flutter/material.dart';
import 'package:jlptgrammar/common/global.dart';
import 'package:jlptgrammar/pages/edit_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:typed_data';

class GrammarItemPage extends StatefulWidget {
  final List list;
  final int index;
  const GrammarItemPage({
    Key? key,
    required this.list,
    required this.index,
  }) : super(key: key);
  @override
  _GrammarItemPageState createState() => _GrammarItemPageState();
}

class _GrammarItemPageState extends State<GrammarItemPage> {
  void openURL(url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw '无法启动 $url';
    }
  }

  @override
  Widget build(BuildContext context) {
      return ValueListenableBuilder(
        valueListenable: g,
        builder: (BuildContext context, int value, Widget? child) {
          return Scaffold(
            backgroundColor: themeConfig['backgroundColor'],
            appBar: AppBar(
              title: Text(widget.list[widget.index].name.toString(), style: TextStyle(color: themeConfig['titleColor'])),
              backgroundColor: themeConfig['themeColor'],
              leading: Builder(builder: (context) {
                return IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back, color: themeConfig['iconColor']),
                );
              }),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          GrammarItemEditPage(title: '更新', list: widget.list, index: widget.index,)),
                    );
                  },
                  icon: const Icon(Icons.edit),
                  color: themeConfig['iconColor'],
                ),
                PopupMenuButton(
                    icon: Icon(Icons.more_vert, color: themeConfig['iconColor']),
                    color: themeConfig['backgroundColor'],
                    onSelected: (value) async {
                      if(value == 1) {
                        // 网页内搜索
                        String searchSite = 'https://www.google.com.hk/search?q=';
                        String q = widget.list[widget.index].name;
                        String url = "$searchSite$q";

                        print("搜索链接: $url");
                        openURL(Uri.parse(url));
                      }
                      else if(value == 2) {
                        // 截图分享
                        Uint8List? tempImage = await st.capturePngToByte(widget.index, widget.list);
                        await st.shareImage(tempImage);
                      }
                      else if(value == 3) {
                        // 删除条目
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: themeConfig['backgroundColor'],
                              title: Text("提示", style: TextStyle(color: themeConfig['textColor'])),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4))
                              ),
                              content: Text("确认删除此条目？", style: TextStyle(fontSize: 18, color: themeConfig['textColor'])),
                              actions: <Widget>[
                                MaterialButton(
                                  child: const Text("确认", style: TextStyle(color: Colors.red, fontSize: 15)),
                                  onPressed: () {
                                    int id = widget.list[widget.index].id;
                                    // TODO 索引越界 bug, 但是能跑 :D
                                    widget.list.removeAt(widget.index);
                                    grammar.databaseTool.deleteData(id);
                                    // print(widget.list);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                ),
                                MaterialButton(
                                  child: Text("取消", style: TextStyle(color: themeConfig['textColor'], fontSize: 15)),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          }
                        );
                      }
                      else {

                      }
                    },
                    onCanceled: () {
                      print("canceled");
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                        // TODO 添加功能
                        PopupMenuItem(value: 1, child: Text("在网页搜索", style: TextStyle(color: themeConfig['textColor']))),
                        PopupMenuItem(value: 2, child: Text("分享", style: TextStyle(color: themeConfig['textColor']))), // 图片分享开发中
                        const PopupMenuItem(
                          value: 3,
                          child: Text("删除", style: TextStyle(color: Colors.red))
                        ),
                      ];
                    },
                ),
              ],
            ),
            body: SelectionArea(
              child: Container(
                color: themeConfig['backgroundColor'],
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(0),
                    child: RepaintBoundary(
                      key: repaintWidgetKey,
                      child: Column(
                        children: [
                          Container(
                            color: themeConfig['backgroundColor'],
                            padding: const EdgeInsets.only(left: 10, top: 10),
                            child: Row(
                              children: [
                                RawChip(
                                  label: Text("文型", style: TextStyle(color: themeConfig['titleColor'], fontSize: 16)),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0), side: const BorderSide(color: Colors.transparent)),
                                  backgroundColor: themeConfig['themeColor'],
                                  padding: const EdgeInsets.all(2),
                                  selected: false,
                                )
                              ],
                            ),
                          ),
                          Container(
                            color: themeConfig['backgroundColor'],
                            // margin: const EdgeInsets.only(left: 10, right: 0, top: 0, bottom: 20),
                            padding: const EdgeInsets.only(left: 11, top: 5, right: 11),
                            alignment: Alignment.topLeft,
                            child: Text(
                              "${widget.list[widget.index].name ?? ("无内容")}",
                              style: TextStyle(
                                fontSize: double.parse(setFontSize),
                                color: themeConfig['textColor'],
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            color: themeConfig['backgroundColor'],
                            padding: const EdgeInsets.only(left: 10, top: 15),
                            child: Row(
                              children: [
                                RawChip(
                                  label: Text("意味", style: TextStyle(color: themeConfig['titleColor'], fontSize: 16)),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0), side: const BorderSide(color: Colors.transparent)),
                                  backgroundColor: themeConfig['themeColor'],
                                  padding: const EdgeInsets.all(2),
                                  selected: false,
                                )
                              ],
                            ),
                          ),
                          Container(
                            color: themeConfig['backgroundColor'],
                            // margin: const EdgeInsets.only(left: 10, right: 0, top: 0, bottom: 20),
                            padding: const EdgeInsets.only(left: 11, top: 5, right: 11),
                            alignment: Alignment.topLeft,
                            child: Text(
                              "${widget.list[widget.index].mean ?? ("无内容")}",
                              style: TextStyle(
                                fontSize: double.parse(setFontSize),
                                color: themeConfig['textColor'],
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            color: themeConfig['backgroundColor'],
                            padding: const EdgeInsets.only(left: 10, top: 15),
                            child: Row(
                              children: [
                                RawChip(
                                  label: Text("接続", style: TextStyle(color: themeConfig['titleColor'], fontSize: 16)),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0), side: const BorderSide(color: Colors.transparent)),
                                  backgroundColor: themeConfig['themeColor'],
                                  padding: const EdgeInsets.all(2),
                                  selected: false,
                                )
                              ],
                            ),
                          ),
                          Container(
                            color: themeConfig['backgroundColor'],
                            // margin: const EdgeInsets.only(left: 10, right: 0, top: 0, bottom: 20),
                            padding: const EdgeInsets.only(left: 11, top: 5, right: 11),
                            alignment: Alignment.topLeft,
                            child: Text(
                              "${widget.list[widget.index].grammar ?? ("无内容")}",
                              style: TextStyle(
                                fontSize: double.parse(setFontSize),
                                color: themeConfig['textColor'],
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            color: themeConfig['backgroundColor'],
                            padding: const EdgeInsets.only(left: 10, top: 15),
                            child: Row(
                              children: [
                                RawChip(
                                  label: Text("例文", style: TextStyle(color: themeConfig['titleColor'], fontSize: 16)),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0), side: const BorderSide(color: Colors.transparent)),
                                  backgroundColor: themeConfig['themeColor'],
                                  padding: const EdgeInsets.all(2),
                                  selected: false,
                                )
                              ],
                            ),
                          ),
                          Container(
                            color: themeConfig['backgroundColor'],
                            // margin: const EdgeInsets.only(left: 10, right: 0, top: 0, bottom: 20),
                            padding: const EdgeInsets.only(left: 11, top: 5, right: 11),
                            alignment: Alignment.topLeft,
                            child: Text(
                              "${widget.list[widget.index].example ?? ("无内容")}",
                              style: TextStyle(
                                fontSize: double.parse(setFontSize),
                                color: themeConfig['textColor'],
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            color: themeConfig['backgroundColor'],
                            padding: const EdgeInsets.only(left: 10, top: 15),
                            child: Row(
                              children: [
                                RawChip(
                                  label: Text("ノート", style: TextStyle(color: themeConfig['titleColor'], fontSize: 16)),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0), side: const BorderSide(color: Colors.transparent)),
                                  backgroundColor: themeConfig['themeColor'],
                                  padding: const EdgeInsets.all(2),
                                  selected: false,
                                )
                              ],
                            ),
                          ),
                          Container(
                            color: themeConfig['backgroundColor'],
                            // margin: const EdgeInsets.only(left: 10, right: 0, top: 0, bottom: 20),
                            padding: const EdgeInsets.only(left: 11, top: 5, bottom: 20, right: 11),
                            alignment: Alignment.topLeft,
                            child: Text(
                              "${widget.list[widget.index].notes ?? ("无内容")}",
                              style: TextStyle(
                                fontSize: double.parse(setFontSize),
                                color: themeConfig['textColor'],
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ),
          );
        }
      );
   }
}