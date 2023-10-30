import 'package:flutter/material.dart';
import 'package:jlptgrammar/common/global.dart';
import 'package:jlptgrammar/utils/text_tool.dart';
import 'package:jlptgrammar/models/grammar_item_model.dart';

class GrammarItemAddPage extends StatefulWidget {
  // TODO 添加参数，分类页默认添加分类
  final String title;
  const GrammarItemAddPage({Key? key, required this.title}) : super(key: key);
  @override
  State<GrammarItemAddPage> createState() => _GrammarItemAddPageState();
}

class _GrammarItemAddPageState extends State<GrammarItemAddPage> {
  final List<String> levelArray = ["其他", "N1", "N2", "N3", "N4", "N5"];
  String setLevel = "其他";
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  TextEditingController textEditingController3 = TextEditingController();
  TextEditingController textEditingController4 = TextEditingController();
  TextEditingController textEditingController5 = TextEditingController();


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
        actions: [
          DropdownButton(
            style: TextStyle(color: themeConfig['textColor']),
            dropdownColor: themeConfig['backgroundColor'],
            icon: Icon(Icons.arrow_drop_down_rounded, color: themeConfig['iconColor']),
            value: setLevel,
            items: levelArray.map((String item) => DropdownMenuItem<String>(
              key: Key(item),
              value: item,
              child: Text(item, style: TextStyle(
                // TODO 这里需要一种选择色
                color: item == setLevel ? themeConfig['textColor'] : themeConfig['textColor']
              )),
            )).toList(),
            // 自定义选中项显示
            selectedItemBuilder: (BuildContext context) {
              return levelArray.map<Widget>((String item) {
                return Center(
                  child: Text(
                    item,
                    style: TextStyle(color: themeConfig['titleColor']),
                  ),
                );
              }).toList();
            },
            onChanged: (value) {
              setState(() {
                setLevel = value!;
              });
            },
            underline: Container(),
          ),
        ],
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
                      controller: textEditingController1,
                      decoration: InputDecoration(
                        labelText: '文型',
                        labelStyle: TextStyle(
                          fontSize: double.parse(setFontSize),
                          color: themeConfig['labelColor']
                        ),
                        floatingLabelStyle: TextStyle(
                          fontSize: 18,
                          color: themeConfig['floatingLabelColor']
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: themeConfig['enabledBorderColor'], width: 1)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: themeConfig['focusedBorderColor'], width: 2)
                        )
                      ),
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: double.parse(setFontSize),
                        height: 1.5,  // 1.5 倍行高
                        color: themeConfig['textColor']
                      ),
                    ),
                  ),
                  LayoutBuilder(
                    builder: (context, size){
                      TextSpan text = const TextSpan(
                        // text: yourTextController.text,
                        // style: yourTextStyle,
                      );

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
                          controller: textEditingController2,
                          decoration: InputDecoration(
                              labelText: '接続',
                              labelStyle: TextStyle(
                                  fontSize: double.parse(setFontSize),
                                  color: themeConfig['labelColor']
                              ),
                              floatingLabelStyle: TextStyle(
                                  fontSize: 18,
                                  color: themeConfig['floatingLabelColor']
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: themeConfig['enabledBorderColor'], width: 1)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: themeConfig['focusedBorderColor'], width: 2)
                              )
                          ),
                          maxLines: lines < maxLines ? null : maxLines,
                          style: TextStyle(
                              fontSize: double.parse(setFontSize),
                              height: 1.5,  // 1.5 倍行高
                              color: themeConfig['textColor']
                          ),
                        ),
                      );
                    }
                ),
                LayoutBuilder(
                    builder: (context, size){
                      TextSpan text = const TextSpan(
                        // text: yourTextController.text,
                        // style: yourTextStyle,
                      );

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
                          controller: textEditingController3,
                          decoration: InputDecoration(
                              labelText: '意味',
                              labelStyle: TextStyle(
                                  fontSize: double.parse(setFontSize),
                                  color: themeConfig['labelColor']
                              ),
                              floatingLabelStyle: TextStyle(
                                  fontSize: 18,
                                  color: themeConfig['floatingLabelColor']
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: themeConfig['enabledBorderColor'], width: 1)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: themeConfig['focusedBorderColor'], width: 2)
                              )
                          ),
                          maxLines: lines < maxLines ? null : maxLines,
                          style: TextStyle(
                              fontSize: double.parse(setFontSize),
                              height: 1.5,  // 1.5 倍行高
                              color: themeConfig['textColor']
                          ),
                        ),
                      );
                    }
                ),
                LayoutBuilder(
                    builder: (context, size){
                      TextSpan text = const TextSpan(
                        // text: yourTextController.text,
                        // style: yourTextStyle,
                      );

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
                          controller: textEditingController4,
                          decoration: InputDecoration(
                              labelText: '例文',
                              labelStyle: TextStyle(
                                  fontSize: double.parse(setFontSize),
                                  color: themeConfig['labelColor']
                              ),
                              floatingLabelStyle: TextStyle(
                                  fontSize: 18,
                                  color: themeConfig['floatingLabelColor']
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: themeConfig['enabledBorderColor'], width: 1)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: themeConfig['focusedBorderColor'], width: 2)
                              )
                          ),
                          maxLines: lines < maxLines ? null : maxLines,
                          style: TextStyle(
                              fontSize: double.parse(setFontSize),
                              height: 1.5,  // 1.5 倍行高
                              color: themeConfig['textColor']
                          ),
                        ),
                      );
                    }
                ),
                LayoutBuilder(
                    builder: (context, size){
                      TextSpan text = const TextSpan(
                        // text: TextController.text,
                        // style: TextStyle,
                      );

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
                          controller: textEditingController5,
                          decoration: InputDecoration(
                              labelText: 'ノート',
                              labelStyle: TextStyle(
                                  fontSize: double.parse(setFontSize),
                                  color: themeConfig['labelColor']
                              ),
                              floatingLabelStyle: TextStyle(
                                  fontSize: 18,
                                  color: themeConfig['floatingLabelColor']
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: themeConfig['enabledBorderColor'], width: 1)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: themeConfig['focusedBorderColor'], width: 2)
                              )
                          ),
                          maxLines: lines < maxLines ? null : maxLines,
                          style: TextStyle(
                              fontSize: double.parse(setFontSize),
                              height: 1.5,  // 1.5 倍行高
                              color: themeConfig['textColor']
                          ),
                        ),
                      );
                    }
                ),
                MaterialButton(
                  onPressed: () {
                    if(textEditingController1.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('请至少输入文型～'), duration: Duration(seconds: 1)));
                      setState(() {

                      });
                    }
                    else { // 条目写入数据库后刷新数据
                      TextTool t = TextTool();
                      GrammarItem gi = t.insertDataGenerator(
                        textEditingController1,
                        textEditingController2,
                        textEditingController3,
                        textEditingController4,
                        textEditingController5,
                        setLevel,
                      );
                      grammar.databaseTool.insertData(gi);
                      // 临时加入 list 解决页面同步
                      switch (setLevel) {
                        case 'N1':
                          {
                            grammar.listN1.add(gi);
                          }
                          break;
                        case 'N2':
                          {
                            grammar.listN2.add(gi);
                          }
                          break;
                        case 'N3':
                          {
                            grammar.listN3.add(gi);
                          }
                          break;
                        case 'N4':
                          {
                            grammar.listN4.add(gi);
                          }
                          break;
                        case 'N5':
                          {
                            grammar.listN5.add(gi);
                          }
                          break;
                          defalut:
                          {
                            grammar.listN0.add(gi);
                          }
                          break;
                      }
                      Navigator.pop(context);
                    }
                  },
                  minWidth: double.infinity,
                  height: 50.0,
                  color: themeConfig['themeColor'],
                  textColor: themeConfig['titleColor'],
                  child: const Text(
                    "添加",
                    style: TextStyle(fontSize: 20)
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}