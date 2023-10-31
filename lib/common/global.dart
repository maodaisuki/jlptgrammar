import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jlptgrammar/utils/db_tool.dart';
import 'package:jlptgrammar/utils/share_tool.dart';
import 'package:jlptgrammar/models/grammar_item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:jlptgrammar/common/theme.dart';

ShareTool st = ShareTool();

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
    print("初始化完成");
    return data;
    // print(grammarList);
  }
}