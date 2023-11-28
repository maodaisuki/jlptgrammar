import 'package:flutter/material.dart';
import 'package:jlptgrammar/common/global.dart';
import 'package:jlptgrammar/widgets/search_widget.dart';
import 'package:jlptgrammar/widgets/listtile_widget.dart';
import 'package:jlptgrammar/pages/add_page.dart';

class GrammarListPage extends StatefulWidget {
  final List list;
  final String title;
  final String tag;
  const GrammarListPage({
    Key? key,
    required this.list,
    required this.title,
    required this.tag,
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
            backgroundColor: themeConfig['backgroundColor'],
            appBar: AppBar(
              title: Text(widget.title,
                  style: TextStyle(color: themeConfig['titleColor'])),
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
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    showSearch(
                        context: context,
                        delegate:
                            GrammarSearchDelegate(grammarList: widget.list));
                  },
                  icon: const Icon(Icons.search),
                  color: themeConfig['iconColor'],
                ),
              ],
            ),
            body: widget.list.isEmpty
                ? Center(
                    child: Text("当前没有数据",
                        style: TextStyle(
                            fontSize: 20, color: themeConfig['textColor'])))
                : Center(
                    child: ListView.builder(
                        itemCount: widget.list.length,
                        itemBuilder: (context, index) {
                          return GrammarListItem(
                              grammarList: widget.list, index: index);
                        }),
                  ),
            floatingActionButton: FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor:
                  themeConfig['floatingActionButtonBackgroundColor'],
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GrammarItemAddPage(
                        title: '添加条目',
                        tag: widget.tag,
                        tempList: widget.list,
                      ),
                    ));
              },
              tooltip: 'Add item',
              child: Icon(Icons.add,
                  color: themeConfig['floatingActionButtonIconColor'],
                  size: 30),
            ),
          );
        });
  }
}
