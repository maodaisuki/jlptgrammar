import 'package:flutter/material.dart';
import 'package:jlptgrammar/common/global.dart';
import 'package:jlptgrammar/pages/edit_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:typed_data';

class QuizAnswerPage extends StatefulWidget {
  final List list;
  final int index;
  const QuizAnswerPage({
    Key? key,
    required this.list,
    required this.index,
  }) : super(key: key);
  @override
  _QuizAnswerPageState createState() => _QuizAnswerPageState();
}

class _QuizAnswerPageState extends State<QuizAnswerPage> {
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
              title: Text(widget.list[widget.index].name.toString(),
                  style: TextStyle(color: themeConfig['titleColor'])),
              backgroundColor: themeConfig['themeColor'],
              leading: Builder(builder: (context) {
                return IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back, color: themeConfig['iconColor']),
                );
              }),
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
                                label: Text("文型",
                                    style: TextStyle(
                                        color: themeConfig['titleColor'],
                                        fontSize: 16)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    side: const BorderSide(
                                        color: Colors.transparent)),
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
                          padding: const EdgeInsets.only(
                              left: 11, top: 5, right: 11),
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
                                label: Text("意味",
                                    style: TextStyle(
                                        color: themeConfig['titleColor'],
                                        fontSize: 16)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    side: const BorderSide(
                                        color: Colors.transparent)),
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
                          padding: const EdgeInsets.only(
                              left: 11, top: 5, right: 11),
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
                                label: Text("接続",
                                    style: TextStyle(
                                        color: themeConfig['titleColor'],
                                        fontSize: 16)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    side: const BorderSide(
                                        color: Colors.transparent)),
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
                          padding: const EdgeInsets.only(
                              left: 11, top: 5, right: 11),
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
                                label: Text("例文",
                                    style: TextStyle(
                                        color: themeConfig['titleColor'],
                                        fontSize: 16)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    side: const BorderSide(
                                        color: Colors.transparent)),
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
                          padding: const EdgeInsets.only(
                              left: 11, top: 5, right: 11),
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
                                label: Text("ノート",
                                    style: TextStyle(
                                        color: themeConfig['titleColor'],
                                        fontSize: 16)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    side: const BorderSide(
                                        color: Colors.transparent)),
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
                          padding: const EdgeInsets.only(
                              left: 11, top: 5, bottom: 20, right: 11),
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
        });
  }
}
