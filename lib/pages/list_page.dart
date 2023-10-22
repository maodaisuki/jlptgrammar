import 'package:flutter/material.dart';
import 'package:jlptgrammar/common/global.dart';
import 'package:jlptgrammar/widgets/search_widget.dart';
import 'package:jlptgrammar/widgets/listtile_widget.dart';
import 'package:jlptgrammar/pages/add_page.dart';


class GrammarListPage extends StatefulWidget {
  final List list;
  final String title;
  const GrammarListPage({
    Key? key,
    required this.list,
    required this.title,
  }) : super(key: key);
  @override
  _GrammarListPageState createState() => _GrammarListPageState();
}

class _GrammarListPageState extends State<GrammarListPage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: g,
        builder: (BuildContext context, int value, Widget? child) {
          return Scaffold(
            appBar: AppBar(
              // 根据等级匹配标题 TODO
              title: Text(widget.title, style: TextStyle(color: titleColors[0])),
              backgroundColor: Colors.deepPurple,
              leading: Builder(builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(
                        context
                    );
                  },
                  color: Colors.white,
                );
              }),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: GrammarSearchDelegate(grammarList: widget.list));
                  },
                  icon: const Icon(Icons.search),
                  color: Colors.white,
                ),
              ],
            ),

            body: widget.list.isEmpty
                ? const Center(
                child: Center(
                  child: Text("当前没有数据", style: TextStyle(fontSize: 20)),
                )
            )
                : Center(
              child: ListView.builder(
                  itemCount: widget.list.length,
                  itemBuilder: (context, index) {
                    return GrammarListItem(grammarList: widget.list, index: index);
                  }
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
    );
  }
}