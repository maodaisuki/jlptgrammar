import 'package:flutter/material.dart';
import 'package:jlptgrammar/common/global.dart';
import 'listtile_widget.dart';

class GrammarSearchDelegate extends SearchDelegate {
  final List grammarList;
  GrammarSearchDelegate({
    Key? key,
    required this.grammarList,
  });
  List searchResult = [];
  List tempResult = [];
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: themes[0],
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.white70),
        ),
        textTheme: Theme.of(context).textTheme.copyWith(
              titleLarge: TextStyle(color: textColors[1]),
            ),
        textSelectionTheme: const TextSelectionThemeData(
          selectionColor: Colors.blue,
          selectionHandleColor: Colors.blueAccent,
          cursorColor: Colors.deepPurpleAccent,
        ));
  }

  Widget build(BuildContext context) {
    return Theme(
      data: appBarTheme(context),
      child: Scaffold(
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
        icon: const Icon(Icons.clear, color: Colors.white),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () {
        close(context, null);
      },
    );
  }



  @override
  Widget buildResults(BuildContext context) {
    if(searchResult.isEmpty && tempResult.isEmpty) {
      print("准备数据");
      tempResult = grammarList;
      searchResult = grammarList;
    }
    searchResult = tempResult;
    tempResult = [];
    for (int i = 0; i < searchResult.length; i++) {
      if (searchResult[i].name.contains(query)) {
        print("搜索建议匹配成功");
        tempResult.add(searchResult[i]);
      }
    }
    if(tempResult.isEmpty) {
      return const Center(
        child: Text(
          '没有匹配结果',
          style: TextStyle(fontSize: 18),
        ),
      );
    }
    return ValueListenableBuilder(
        valueListenable: g,
        builder: (BuildContext context, int value, Widget? child) {
          print("重构搜索结果");
          return Center(
            child: ListView.builder(
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
    return const Center(
      child: Text("回车键搜索", style: TextStyle(fontSize: 18)),
    );
  }
}
