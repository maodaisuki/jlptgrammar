import 'package:flutter/material.dart';
import 'package:jlptgrammar/common/global.dart';
import 'listtile_widget.dart';

class GrammarSearchDelegate extends SearchDelegate {
  final List grammarList;
  GrammarSearchDelegate({
    Key? key,
    required this.grammarList,
  });
  List searchList = [];
  List tempResult = [];

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: themeConfig['themeColor']
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.white70),
        ),
        textTheme: Theme.of(context).textTheme.copyWith(
              titleLarge: const TextStyle(color: Colors.white),
            ),
        textSelectionTheme: const TextSelectionThemeData(
          selectionColor: Colors.blue,
          selectionHandleColor: Colors.blueAccent,
          cursorColor: Colors.white,
        ));
  }

  Widget build(BuildContext context) {
    return Theme(
      data: appBarTheme(context),
      child: Scaffold(
        backgroundColor: themeConfig['backgroundColor'],
        appBar: AppBar(
          title: const Text("Search"),
        ),
        body: ValueListenableBuilder(
          valueListenable: g,
          builder: (BuildContext context, int value, Widget? child) {
            return buildSuggestions(context);
          }),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear, color: themeConfig['iconColor']),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: themeConfig['iconColor']),
      onPressed: () {
        close(context, null);
      },
    );
  }



  @override
  Widget buildResults(BuildContext context) {
    if(searchList.isEmpty && tempResult.isEmpty) {
      print("准备数据");
      tempResult = grammarList;
      searchList = grammarList;
    }
    searchList = tempResult;
    tempResult = [];
    for (int i = 0; i < searchList.length; i++) {
      // 搜索条目名和释义
      if (searchList[i].name.contains(query) || searchList[i].mean.contains(query)) {
        print("搜索建议匹配成功");
        tempResult.add(searchList[i]);
      }
    }
    if(tempResult.isEmpty) {
      return Container(
        color: themeConfig['backgroundColor'],
        child: Center(
          child: Text(
            '没有匹配结果',
            style: TextStyle(fontSize: 18, color: themeConfig['textColor']),
          ),
        ),
      );
    }
    return ValueListenableBuilder(
        valueListenable: g,
        builder: (BuildContext context, int value, Widget? child) {
          print("重构搜索结果");
          return Scaffold(
            backgroundColor: themeConfig['backgroundColor'],
            body: ListView.builder(
                itemCount: tempResult.length,
                itemBuilder: (context, index) {
                  return GrammarListItem(
                    grammarList: tempResult,
                    index: index,
                  );
                }),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // searchResult = [];
    // for (int i = 0; i < grammarList.length; i++) {
    //   if (grammarList[i].name.contains(query)) {
    //     print("搜索建议匹配成功");
    //     searchResult.add(grammarList[i]);
    //   }
    // }
    // if(searchResult.isEmpty) {
    //   return const Center(
    //     child: Text(
    //       '没有匹配结果',
    //       style: TextStyle(fontSize: 18),
    //     ),
    //   );
    // }
    // return Center(
    //   child: ListView.builder(
    //       itemCount: searchResult.length,
    //       itemBuilder: (context, index) {
    //         return GrammarListItem(
    //           grammarList: searchResult,
    //           index: index,
    //         );
    //       }),
    // );
    return Container(
      color: themeConfig['backgroundColor'],
      child: Center(
        child: Text("回车键搜索", style: TextStyle(fontSize: 18, color: themeConfig['textColor'])),
    ));
  }
}
