import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jlptgrammar/common/db_tool.dart';
import 'package:jlptgrammar/common/share_tool.dart';
import 'package:jlptgrammar/models/grammar_item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:jlptgrammar/common/config_tool.dart';

const Map lightTheme = {
  'themeColor': Colors.deepPurple,
  'backgroundColor': Colors.white,
  'lineColor': Colors.black12,
  'titleColor': Colors.white,
  'subtitleColor': Colors.white,
  'iconColor': Colors.white,
  'hintColor': Colors.white70,
  'textColor': Colors.black,
  'drawerIconButtonColor': Colors.black,
  'floatingActionButtonBackgroundColor': Color.fromRGBO(224, 213, 255, 1),
  'floatingActionButtonIconColor': Color.fromRGBO(79, 72, 94, 0.8),
  'labelColor': Color.fromRGBO(80, 80, 80, 1),
  'floatingLabelColor': Colors.deepPurple,
  'enabledBorderColor': Colors.black,
  'focusedBorderColor': Colors.deepPurple,
  'drawerTitleColor': Colors.deepPurple,
};

const Map nightTheme = {
  'themeColor': Color.fromRGBO(31, 30, 30, 1),
  'backgroundColor': Color.fromRGBO(43, 43, 43, 1),
  'lineColor': Colors.white30,
  'titleColor': Colors.white,
  'subtitleColor': Colors.white,
  'iconColor': Colors.white,
  'hintColor': Colors.white70,
  'textColor': Colors.white,
  'drawerIconColor': Colors.white,
  'floatingActionButtonBackgroundColor': Color.fromRGBO(31, 30, 30, 1),
  'floatingActionButtonIconColor': Colors.white,
  'labelColor': Color.fromRGBO(200, 200, 200, 1),
  'floatingLabelColor': Colors.white,
  'enabledBorderColor': Colors.grey,
  'focusedBorderColor': Colors.white,
  'drawerTitleColor': Colors.white,
};

ShareTool st = ShareTool();
ConfigTool ct = ConfigTool();

late bool isLightTheme;
late String setFontSize;
late Map themeConfig;

ValueNotifier<int> g = ValueNotifier<int>(0);
Grammar grammar = Grammar();
GlobalKey repaintWidgetKey = GlobalKey();


class Grammar {
  late List<GrammarItem> grammarList;
  late List<GrammarItem> listN1;
  late List<GrammarItem> listN2;
  late List<GrammarItem> listN3;
  late List<GrammarItem> listN4;
  late List<GrammarItem> listN5;
  // 方言
  late List<GrammarItem> listN6;
  // 其他
  late List<GrammarItem> listN0;
  late Database grammardb;
  late DatabaseTool databaseTool;
  late DatabaseHelper databaseHelper;

  Grammar() {

    init().then((_) async {
      print("实例化 grammarList: $grammarList");
      print("实例化 grammardb: $grammardb");
      // 加 1 避免数据为空一直加载
      g.value = grammarList.length + 1;
    });
  }

  Future<List<GrammarItem>> init() async {
    databaseTool = DatabaseTool();
    Completer<void> completer = Completer<void>();
    databaseHelper = databaseTool.dbHelper;
    List<GrammarItem> data = await databaseTool.getAllData();
    completer.complete();
    await completer.future;
    grammardb = databaseTool.dbHelper.grammarDatabase!;
    grammarList = await databaseTool.getAllData();
    listN0 = await databaseTool.getLevelGrammarList("N0");
    listN1 = await databaseTool.getLevelGrammarList("N1");
    listN2 = await databaseTool.getLevelGrammarList("N2");
    listN3 = await databaseTool.getLevelGrammarList("N3");
    listN4 = await databaseTool.getLevelGrammarList("N4");
    listN5 = await databaseTool.getLevelGrammarList("N5");
    listN6 = await databaseTool.getLevelGrammarList("N6");
    print("初始化完成");
    return data;
    // print(grammarList);
  }
}