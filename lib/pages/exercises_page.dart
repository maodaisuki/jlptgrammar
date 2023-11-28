import 'package:flutter/material.dart';
import 'package:jlptgrammar/common/global.dart';
import 'package:jlptgrammar/models/grammar_item_model.dart';
import 'package:jlptgrammar/pages/item_page.dart';
import 'package:jlptgrammar/pages/quiz_answer_page.dart';
import 'package:jlptgrammar/utils/quiz_tool.dart';

class ExercisesPage extends StatefulWidget {
  const ExercisesPage({
    Key? key,
  }) : super(key: key);
  @override
  _ExercisesPageState createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  QuizGenerator qg = QuizGenerator();
  @override
  Widget build(BuildContext context) {
    GrammarItem quiz = qg.randomListItem();
    return Scaffold(
      backgroundColor: themeConfig['backgroundColor'],
      appBar: AppBar(
        // TODO 考虑修改练习数量
        title: Text("练习题", style: TextStyle(color: themeConfig['titleColor'])),
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
      body: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TODO 居中，保持距离，使用题目生成器
                Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.2,
                      left: MediaQuery.of(context).size.width * 0.1,
                      right: MediaQuery.of(context).size.width * 0.1),
                  child: Center(
                    child: Text(
                      quiz.name.toString(),
                      style: TextStyle(
                          fontSize: 25, color: themeConfig['textColor']),
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  margin: EdgeInsets.only(
                      bottom: 80,
                      left: MediaQuery.of(context).size.width * 0.1,
                      right: MediaQuery.of(context).size.width * 0.1),
                  child: Row(
                    children: [
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(130, 194, 171, 1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            height: 50.0,
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: MaterialButton(
                              onPressed: () {
                                // 下一个
                                setState(() {
                                  quiz = qg.randomListItem();
                                });
                              },
                              child: Text('认识',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                            ),
                          )),
                      const Spacer(),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(235, 147, 39, 1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            height: 50.0,
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: MaterialButton(
                              onPressed: () {
                                // 构建 item 页面
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => QuizAnswerPage(
                                            list: grammar.grammarList,
                                            index: grammar.grammarList
                                                .indexOf(quiz))));
                              },
                              child: Text('忘记',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
