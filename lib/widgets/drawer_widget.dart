import 'package:flutter/material.dart';
import 'package:jlptgrammar/common/global.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({
    Key? key,
  }) : super(key: key);
  @override
  _MenuDrawerState createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  final List<String> fontSizeArray = ["18", "20", "22", "24"];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Drawer(
        child: ListView(
          // TODO 添加条目
          children: [
            const ListTile(
              title: Text('Grammar'),
            ),
            const Divider(
              height: 0.5,
              indent: 0,
              color: Colors.black12,
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text("JLPT N5"),
              onTap: () {
                // 关闭抽屉
                Scaffold.of(context).closeDrawer();
                Navigator.of(context).pushNamed('/n5');
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text("JLPT N4"),
              onTap: () {
                // 关闭抽屉
                Scaffold.of(context).closeDrawer();
                Navigator.of(context).pushNamed('/n4');
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text("JLPT N3"),
              onTap: () {
                // 关闭抽屉
                Scaffold.of(context).closeDrawer();
                Navigator.of(context).pushNamed('/n3');
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text("JLPT N2"),
              onTap: () {
                // 关闭抽屉
                Scaffold.of(context).closeDrawer();
                Navigator.of(context).pushNamed('/n2');
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text("JLPT N1"),
              onTap: () {
                // 关闭抽屉
                Scaffold.of(context).closeDrawer();
                Navigator.of(context).pushNamed('/n1');
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text("方言文法"),
              onTap: () {
                // 关闭抽屉
                Scaffold.of(context).closeDrawer();
                Navigator.of(context).pushNamed('/n6');
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text("其他语法"),
              onTap: () {
                // 关闭抽屉
                Scaffold.of(context).closeDrawer();
                Navigator.of(context).pushNamed('/n0');
              },
            ),
            const ListTile(
              title: Text(''),
            ),
            const ListTile(
              title: Text('设置'),
            ),
            const Divider(
              height: 0.5,
              indent: 0,
              color: Colors.black12,
            ),
            ListTile(
              leading: const Icon(Icons.text_fields),
              title: const Text('文本大小'),
              trailing: DropdownButton(
                icon: const Icon(Icons.arrow_drop_down_rounded, color: Colors.black,),
                value: setFontSize,
                items: fontSizeArray.map((String item) => DropdownMenuItem<String>(
                  key: Key(item),
                  value: item,
                  child: Text(item),
                )).toList(),
                onChanged: (value) {
                  setState(() {
                    setFontSize = value!;
                  });
                },
                underline: Container(),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.outbox),
              title: const Text("导出数据"),
              onTap: () {

              },
              enabled: false,
            ),
            ListTile(
              leading: const Icon(Icons.sd_card),
              title: const Text("导入数据"),
              onTap: () {

              },
              enabled: false,
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("关于"),
              onTap: () {
                Scaffold.of(context).closeDrawer();
                Navigator.of(context).pushNamed('/about');
              },
            ),
          ],
        ),
      ),
    );
  }
}
