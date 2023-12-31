import 'package:flutter/material.dart';
import 'package:jlptgrammar/common/global.dart';
import 'package:jlptgrammar/utils/text_tool.dart';
import 'package:jlptgrammar/models/grammar_item_model.dart';

class GrammarItemEditPage extends StatefulWidget {
  final String title;
  final List list;
  final int index;
  const GrammarItemEditPage({
    Key? key,
    required this.title,
    required this.list,
    required this.index,
  }) : super(key: key);
  @override
  State<GrammarItemEditPage> createState() => _GrammarItemEditPageState();
}

class _GrammarItemEditPageState extends State<GrammarItemEditPage> {
  TextTool t = TextTool();
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  TextEditingController textEditingController3 = TextEditingController();
  TextEditingController textEditingController4 = TextEditingController();
  TextEditingController textEditingController5 = TextEditingController();
  // 添加其他文本框的TextEditingController

  @override
  void dispose() {
    super.dispose();
    textEditingController1.dispose();
    textEditingController2.dispose();
    textEditingController3.dispose();
    textEditingController4.dispose();
    textEditingController5.dispose();
    // 释放文本框的TextEditingController
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeConfig['backgroundColor'],
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: themeConfig['titleColor'])),
        backgroundColor: themeConfig['themeColor'],
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
            color: themeConfig['iconColor'],
          );
        }),
      ),
      // 文型设置为一行
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 10),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 20),
                  child: TextField(
                    controller: textEditingController1..text = widget.list[widget.index].name ?? "",
                    decoration: InputDecoration(
                        labelText: '文型',
                        labelStyle: TextStyle(fontSize: double.parse(setFontSize), color: themeConfig['labelColor']),
                        floatingLabelStyle: TextStyle(fontSize: 18, color: themeConfig['floatingLabelColor']),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: themeConfig['enabledBorderColor'], width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: themeConfig['focusedBorderColor'], width: 2))),
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: double.parse(setFontSize),
                        height: 1.5, // 1.5 倍行高
                        color: themeConfig['textColor']),
                  ),
                ),
                LayoutBuilder(builder: (context, size) {
                  TextSpan text = const TextSpan();

                  TextPainter tp = TextPainter(
                    text: text,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,
                  );
                  tp.layout(maxWidth: size.maxWidth);

                  int lines = (tp.size.height / tp.preferredLineHeight).ceil();
                  int maxLines = 10;

                  return Container(
                    margin: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 20),
                    child: TextField(
                      controller: textEditingController2..text = widget.list[widget.index].grammar ?? "",
                      decoration: InputDecoration(
                          labelText: '接続',
                          labelStyle: TextStyle(fontSize: double.parse(setFontSize), color: themeConfig['labelColor']),
                          floatingLabelStyle: TextStyle(fontSize: 18, color: themeConfig['floatingLabelColor']),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: themeConfig['enabledBorderColor'], width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: themeConfig['focusedBorderColor'], width: 2))),
                      maxLines: lines < maxLines ? null : maxLines,
                      style: TextStyle(
                          fontSize: double.parse(setFontSize),
                          height: 1.5, // 1.5 倍行高
                          color: themeConfig['textColor']),
                    ),
                  );
                }),
                LayoutBuilder(builder: (context, size) {
                  TextSpan text = const TextSpan();

                  TextPainter tp = TextPainter(
                    text: text,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,
                  );
                  tp.layout(maxWidth: size.maxWidth);

                  int lines = (tp.size.height / tp.preferredLineHeight).ceil();
                  int maxLines = 10;

                  return Container(
                    margin: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 20),
                    child: TextField(
                      controller: textEditingController3..text = widget.list[widget.index].mean ?? "",
                      decoration: InputDecoration(
                          labelText: '意味',
                          labelStyle: TextStyle(fontSize: double.parse(setFontSize), color: themeConfig['labelColor']),
                          floatingLabelStyle: TextStyle(fontSize: 18, color: themeConfig['floatingLabelColor']),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: themeConfig['enabledBorderColor'], width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: themeConfig['focusedBorderColor'], width: 2))),
                      maxLines: lines < maxLines ? null : maxLines,
                      style: TextStyle(
                          fontSize: double.parse(setFontSize),
                          height: 1.5, // 1.5 倍行高
                          color: themeConfig['textColor']),
                    ),
                  );
                }),
                LayoutBuilder(builder: (context, size) {
                  TextSpan text = const TextSpan();

                  TextPainter tp = TextPainter(
                    text: text,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,
                  );
                  tp.layout(maxWidth: size.maxWidth);

                  int lines = (tp.size.height / tp.preferredLineHeight).ceil();
                  int maxLines = 10;

                  return Container(
                    margin: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 20),
                    child: TextField(
                      controller: textEditingController4..text = widget.list[widget.index].example ?? "",
                      decoration: InputDecoration(
                          labelText: '例文',
                          labelStyle: TextStyle(fontSize: double.parse(setFontSize), color: themeConfig['labelColor']),
                          floatingLabelStyle: TextStyle(fontSize: 18, color: themeConfig['floatingLabelColor']),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: themeConfig['enabledBorderColor'], width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: themeConfig['focusedBorderColor'], width: 2))),
                      maxLines: lines < maxLines ? null : maxLines,
                      style: TextStyle(
                          fontSize: double.parse(setFontSize),
                          height: 1.5, // 1.5 倍行高
                          color: themeConfig['textColor']),
                    ),
                  );
                }),
                LayoutBuilder(builder: (context, size) {
                  TextSpan text = const TextSpan();

                  TextPainter tp = TextPainter(
                    text: text,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,
                  );
                  tp.layout(maxWidth: size.maxWidth);

                  int lines = (tp.size.height / tp.preferredLineHeight).ceil();
                  int maxLines = 10;

                  return Container(
                    margin: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 20),
                    child: TextField(
                      controller: textEditingController5..text = widget.list[widget.index].notes ?? "",
                      decoration: InputDecoration(
                          labelText: 'ノート',
                          labelStyle: TextStyle(fontSize: double.parse(setFontSize), color: themeConfig['labelColor']),
                          floatingLabelStyle: TextStyle(fontSize: 18, color: themeConfig['floatingLabelColor']),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: themeConfig['enabledBorderColor'], width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: themeConfig['focusedBorderColor'], width: 2))),
                      maxLines: lines < maxLines ? null : maxLines,
                      style: TextStyle(
                          fontSize: double.parse(setFontSize),
                          height: 1.5, // 1.5 倍行高
                          color: themeConfig['textColor']),
                    ),
                  );
                }),
                MaterialButton(
                  onPressed: () {
                    if (textEditingController1.text.isEmpty) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text('请至少输入文型～'), duration: Duration(seconds: 1)));
                    } else {
                      // 条目写入数据库
                      // 取 list[index].id 进行数据库操作
                      GrammarItem gi = t.updateDataGenerator(
                        widget.list[widget.index].id,
                        textEditingController1,
                        textEditingController2,
                        textEditingController3,
                        textEditingController4,
                        textEditingController5,
                      );
                      grammar.databaseTool.updateData(gi);
                      // 临时存储
                      widget.list[widget.index] = gi;
                      Navigator.pop(context);
                    }
                  },
                  minWidth: double.infinity,
                  height: 50.0,
                  color: themeConfig['themeColor'],
                  textColor: themeConfig['titleColor'],
                  child: const Text("更新", style: TextStyle(fontSize: 20)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
