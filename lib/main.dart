import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jlptgrammar/pages/about_page.dart';
import 'package:jlptgrammar/pages/add_page.dart';
import 'package:jlptgrammar/pages/data_info_page.dart';
import 'package:jlptgrammar/widgets/drawer_widget.dart';
import 'package:jlptgrammar/common/global.dart';
import 'package:jlptgrammar/pages/list_page.dart';
import 'package:jlptgrammar/widgets/listtile_widget.dart';
import 'package:jlptgrammar/widgets/search_widget.dart';

void main() async {
  print("运行APP");
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JLPT Grammar',
      routes:  <String, WidgetBuilder> {
        '/n1': (context) => GrammarListPage(list: grammar.listN1, title: "JLPT N1"),
        '/n2': (context) => GrammarListPage(list: grammar.listN2, title: "JLPT N2"),
        '/n3': (context) => GrammarListPage(list: grammar.listN3, title: "JLPT N3"),
        '/n4': (context) => GrammarListPage(list: grammar.listN4, title: "JLPT N4"),
        '/n5': (context) => GrammarListPage(list: grammar.listN5, title: "JLPT N5"),
        '/n6': (context) => GrammarListPage(list: grammar.listN6, title: "方言文法"),
        '/n0': (context) => GrammarListPage(list: grammar.listN0, title: "其他文法"),
        '/about': (context) => const AboutPage(),
        '/datainfo': (context) => const DataInfoPage(),
      },
      theme: ThemeData(
        // TODO 自定义水波纹 || 消除 bug
        splashFactory: NoSplash.splashFactory,
        colorScheme: ColorScheme.fromSeed(seedColor: themes[0]),
        useMaterial3: true,
      ),
      home: const HomePage(title: "JLPT Grammar")
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  with AutomaticKeepAliveClientMixin {
  DateTime? lastPressTime; //上次点击时间
  late Future<String> initData;
  Grammar allGrammar = grammar;

  Future<String> fetchData() async {
    return "fetchData";
  }

  @override
  void initState() {
    initData = fetchData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ValueListenableBuilder(
        valueListenable: g,
        builder: (BuildContext context, int value, Widget? child) {
          // print("构建页面 grammar.grammarList: ${grammar.grammarList}");
          if (g.value != 0) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('JLPT Grammar', style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.deepPurple,
                leading: Builder(builder: (context) {
                  return IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    color: Colors.white,
                  );
                }),
                actions: <Widget>[
                  IconButton(
                    onPressed: () {
                      showSearch(context: context, delegate: GrammarSearchDelegate(grammarList: allGrammar.grammarList));
                    },
                    icon: const Icon(Icons.search),
                    color: Colors.white,
                  ),
                ],
              ),
              drawer: const MenuDrawer(),
              body: WillPopScope(
                onWillPop: () async {
                  if (lastPressTime == null || DateTime.now().difference(lastPressTime!) > const Duration(seconds: 1)) {
                    //两次点击间隔超过1秒则重新计时
                    lastPressTime = DateTime.now();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('再次点击关闭'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                    return false;
                  }
                  // BUG: Router17 导致返回 true 也无法正常关闭
                  // ios 应使用 exit(0);
                  if(Platform.isAndroid) {
                    SystemNavigator.pop();
                  }
                  else {
                    exit(0);
                  }
                  return true;
                  // 双击退出
                },
                child: allGrammar.grammarList.isEmpty
                  ? const Center(child: Text("当前没有数据", style: TextStyle(fontSize: 20)))
                  : Center(
                    child: ListView.builder(
                        itemCount: allGrammar.grammarList.length,
                        itemBuilder: (context, index) {
                          return GrammarListItem(grammarList: allGrammar.grammarList, index: index,);
                    }),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GrammarItemAddPage(title: '添加条目'),
                  ));
                },
                tooltip: 'Add item',
                child: const Icon(Icons.add),
              ),
            );
          }
          else {
            // print("加载中, grammar.grammarList: ${grammar.grammarList}");
            // print("加载中，grammar.grammarList.length: ${g.value}");
            return Container(
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
    );
  }

  @override
  bool get wantKeepAlive =>true;
}
