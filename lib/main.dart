import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jlptgrammar/pages/about_page.dart';
import 'package:jlptgrammar/pages/add_page.dart';
import 'package:jlptgrammar/pages/data_info_page.dart';
import 'package:jlptgrammar/pages/exercises_page.dart';
import 'package:jlptgrammar/pages/settings_page.dart';
import 'package:jlptgrammar/widgets/drawer_widget.dart';
import 'package:jlptgrammar/common/global.dart';
import 'package:jlptgrammar/pages/list_page.dart';
import 'package:jlptgrammar/widgets/listtile_widget.dart';
import 'package:jlptgrammar/widgets/search_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jlptgrammar/common/theme.dart';
import 'package:jlptgrammar/pages/data_manger_page.dart';

void main() async {
  print("运行APP");
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  setFontSize = await prefs.getString('setFontSize') ?? '18';
  print('setFontSize: $setFontSize');
  isLightTheme = await prefs.getBool('isLightTheme') ?? true;
  print('isLightTheme: $isLightTheme');
  // TODO 去除夜间模式 isLightTheme 参数，默认紫色，切换颜色在 设置->显示
  themeConfig = (await isLightTheme) ? lightTheme : nightTheme;
  print("配置获取完成");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // This widget is the root of your application.

  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'All Grammar',
      routes:  <String, WidgetBuilder> {
        '/n1': (context) => GrammarListPage(list: grammar.listN1, title: "JLPT N1"),
        '/n2': (context) => GrammarListPage(list: grammar.listN2, title: "JLPT N2"),
        '/n3': (context) => GrammarListPage(list: grammar.listN3, title: "JLPT N3"),
        '/n4': (context) => GrammarListPage(list: grammar.listN4, title: "JLPT N4"),
        '/n5': (context) => GrammarListPage(list: grammar.listN5, title: "JLPT N5"),
        '/n0': (context) => GrammarListPage(list: grammar.listN0, title: "其他文法"),
        '/about': (context) => const AboutPage(),
        '/datainfo': (context) => const DataInfoPage(),
        '/exercises': (context) => const ExercisesPage(),
        '/settings': (context) => const SettingsPage(),
        '/dataManger': (context) => const DataMangerPage(),
      },
      theme: ThemeData(
        // TODO 自定义水波纹 || 消除 bug
        splashFactory: NoSplash.splashFactory,
        // colorScheme: ColorScheme.fromSeed(seedColor: themeConfig['themeColor']),
        // 固定颜色
        primaryColor: themeConfig['themeColor'],
        useMaterial3: true,
      ),
      home: const HomePage(title: "All Grammar"),
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
  Grammar allGrammar = grammar;


  Future<String> fetchData() async {
    return "fetchData";
  }

  @override
  void initState() {
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
              backgroundColor: themeConfig['backgroundColor'],
              appBar: AppBar(
                title: Text(widget.title, style: TextStyle(color: themeConfig['titleColor'])),
                backgroundColor: themeConfig['themeColor'],
                leading: Builder(builder: (context) {
                  return IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    color: themeConfig['iconColor'],
                  );
                }),
                actions: <Widget>[
                  IconButton(
                    onPressed: () {
                      showSearch(context: context, delegate: GrammarSearchDelegate(grammarList: allGrammar.grammarList));
                    },
                    icon: const Icon(Icons.search),
                    color: themeConfig['iconColor'],
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
                  ? Container(
                    color: themeConfig['backgroundColor'],
                    child: Center(
                      child: Text("当前没有数据",
                          style: TextStyle(fontSize: 20, color: themeConfig['textColor'])
                      )
                    ),
                  )
                  : Center(
                    child: ListView.builder(
                        itemCount: allGrammar.grammarList.length,
                        itemBuilder: (context, index) {
                          return GrammarListItem(grammarList: allGrammar.grammarList, index: index,);
                    }),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: themeConfig['floatingActionButtonBackgroundColor'],
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GrammarItemAddPage(title: '添加条目'),
                  ));
                },
                tooltip: 'Add item',
                child: Icon(Icons.add, color: themeConfig['floatingActionButtonIconColor'], size: 30),
              ),
            );
          }
          else {
            // print("加载中, grammar.grammarList: ${grammar.grammarList}");
            // print("加载中，grammar.grammarList.length: ${g.value}");
            return Container(
              color: themeConfig['backgroundColor'],
              child: Center(
                child: CircularProgressIndicator(
                  color: themeConfig['titleColor'],
                ),
              ),
            );
          }
        },
    );
  }

  @override
  bool get wantKeepAlive =>true;
}
