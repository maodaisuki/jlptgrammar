import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jlptgrammar/pages/about_page.dart';
import 'package:jlptgrammar/pages/add_page.dart';
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
  // print('setFontSize: $setFontSize');
  isLightTheme = await prefs.getBool('isLightTheme') ?? true;
  // print('isLightTheme: $isLightTheme');
  themeConfig = (await isLightTheme) ? lightTheme : nightTheme;
  print("配置获取完成");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'All Grammar',
      routes: <String, WidgetBuilder>{
        '/n1': (context) => GrammarListPage(list: grammar.listN1, title: "JLPT N1", tag: 'N1'),
        '/n2': (context) => GrammarListPage(list: grammar.listN2, title: "JLPT N2", tag: 'N2'),
        '/n3': (context) => GrammarListPage(list: grammar.listN3, title: "JLPT N3", tag: 'N3'),
        '/n4': (context) => GrammarListPage(list: grammar.listN4, title: "JLPT N4", tag: 'N4'),
        '/n5': (context) => GrammarListPage(list: grammar.listN5, title: "JLPT N5", tag: 'N5'),
        '/n0': (context) => GrammarListPage(list: grammar.listN0, title: "其他文法", tag: 'N0'),
        '/about': (context) => const AboutPage(),
        '/exercises': (context) => const ExercisesPage(),
        '/settings': (context) => const SettingsPage(),
        '/dataManger': (context) => const DataMangerPage(),
      },
      theme: ThemeData(
        splashFactory: NoSplash.splashFactory,
        primaryColor: themeConfig['themeColor'],
        useMaterial3: true,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: isLightTheme ? Color.fromRGBO(184, 150, 103, 1) : Colors.white,
          selectionColor: Colors.blue,
          selectionHandleColor: Colors.blueAccent,
        ),
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

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
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
                // 双击退出
                // 安卓平台退出
                SystemNavigator.pop();
                return true;
              },
              child: allGrammar.grammarList.isEmpty
                  ? Container(
                      color: themeConfig['backgroundColor'],
                      child: Center(
                          child: Text("当前没有数据", style: TextStyle(fontSize: 20, color: themeConfig['textColor']))),
                    )
                  : Center(
                      child: ListView.builder(
                          itemCount: allGrammar.grammarList.length,
                          itemBuilder: (context, index) {
                            return GrammarListItem(
                              grammarList: allGrammar.grammarList,
                              index: index,
                            );
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
                    MaterialPageRoute(
                      builder: (context) => GrammarItemAddPage(
                        title: '添加条目',
                        tag: 'all',
                        tempList: grammar.grammarList,
                      ),
                    ));
              },
              tooltip: 'Add item',
              child: Icon(Icons.add, color: themeConfig['floatingActionButtonIconColor'], size: 30),
            ),
          );
        } else {
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
  bool get wantKeepAlive => true;
}
