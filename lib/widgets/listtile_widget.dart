import 'package:flutter/material.dart';
import 'package:jlptgrammar/common/global.dart';
import 'package:jlptgrammar/pages/item_page.dart';

class GrammarListItem extends StatefulWidget {
  final List grammarList;
  final int index;
  const GrammarListItem({
    Key? key,
    required this.index,
    required this.grammarList,
  }) : super(key: key);
  @override
  _GrammarListItemState createState() => _GrammarListItemState();
}

class _GrammarListItemState extends State<GrammarListItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text((widget.grammarList[widget.index].name).toString(),
              style: TextStyle(fontSize: 18, color: themeConfig['textColor'])),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GrammarItemPage(list: widget.grammarList, index: widget.index)),
            );
          },
          trailing: Icon(Icons.keyboard_arrow_right, color: themeConfig['drawerIconColor']),
        ),
        Divider(
          height: 0.5,
          indent: 0,
          color: themeConfig['lineColor'],
        ),
      ],
    );
  }
}
