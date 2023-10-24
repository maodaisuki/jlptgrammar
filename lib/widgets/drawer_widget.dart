import 'package:flutter/material.dart';
import 'package:jlptgrammar/common/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        backgroundColor: themeConfig['backgroundColor'],
        child: ListView(
          // TODO 添加条目
          children: [
            ListTile(
              title: Text('日本語文法', style: TextStyle(color: themeConfig['textColor'])),
              trailing: IconButton(
                onPressed: () async {
                  Scaffold.of(context).closeDrawer();
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  // 主题切换模式
                  setState(() {
                    if(isLightTheme) {
                      themeConfig = nightTheme;
                      g.value = g.value + 1;
                      isLightTheme = !isLightTheme;
                      prefs.setBool('isLightTheme', isLightTheme);
                    }
                    else {
                      themeConfig = lightTheme;
                      g.value = g.value + 1;
                      isLightTheme = !isLightTheme;
                      prefs.setBool('isLightTheme', isLightTheme);
                    }
                  });
                },
                icon: isLightTheme
                  ? Icon(Icons.nightlight, color: themeConfig['drawerIconColor'])
                  : Icon(Icons.wb_sunny, color: themeConfig['drawerIconColor']),
              ),
            ),
            Divider(
              height: 0.5,
              indent: 0,
              color: themeConfig['lineColor'],
            ),
            ListTile(
              leading: Icon(Icons.book, color: themeConfig['drawerIconColor']),
              title:Text("JLPT N5", style: TextStyle(color: themeConfig['textColor'])),
              onTap: () {
                // 关闭抽屉
                Scaffold.of(context).closeDrawer();
                Navigator.of(context).pushNamed('/n5');
              },
            ),
            ListTile(
              leading: Icon(Icons.book, color: themeConfig['drawerIconColor']),
              title: Text("JLPT N4", style: TextStyle(color: themeConfig['textColor'])),
              onTap: () {
                // 关闭抽屉
                Scaffold.of(context).closeDrawer();
                Navigator.of(context).pushNamed('/n4');
              },
            ),
            ListTile(
              leading: Icon(Icons.book, color: themeConfig['drawerIconColor']),
              title: Text("JLPT N3", style: TextStyle(color: themeConfig['textColor'])),
              onTap: () {
                // 关闭抽屉
                Scaffold.of(context).closeDrawer();
                Navigator.of(context).pushNamed('/n3');
              },
            ),
            ListTile(
              leading: Icon(Icons.book, color: themeConfig['drawerIconColor']),
              title: Text("JLPT N2", style: TextStyle(color: themeConfig['textColor'])),
              onTap: () {
                // 关闭抽屉
                Scaffold.of(context).closeDrawer();
                Navigator.of(context).pushNamed('/n2');
              },
            ),
            ListTile(
              leading: Icon(Icons.book, color: themeConfig['drawerIconColor']),
              title: Text("JLPT N1", style: TextStyle(color: themeConfig['textColor'])),
              onTap: () {
                // 关闭抽屉
                Scaffold.of(context).closeDrawer();
                Navigator.of(context).pushNamed('/n1');
              },
            ),
            ListTile(
              leading: Icon(Icons.book, color: themeConfig['drawerIconColor']),
              title: Text("方言文法", style: TextStyle(color: themeConfig['textColor'])),
              onTap: () {
                // 关闭抽屉
                Scaffold.of(context).closeDrawer();
                Navigator.of(context).pushNamed('/n6');
              },
            ),
            ListTile(
              leading: Icon(Icons.book, color: themeConfig['drawerIconColor']),
              title: Text("其他语法", style: TextStyle(color: themeConfig['textColor'])),
              onTap: () {
                // 关闭抽屉
                Scaffold.of(context).closeDrawer();
                Navigator.of(context).pushNamed('/n0');
              },
            ),
            const ListTile(
              title: Text(''),
            ),
            ListTile(
              title: Text('设置', style: TextStyle(color: themeConfig['textColor'])),
            ),
            Divider(
              height: 0.5,
              indent: 0,
              color: themeConfig['lineColor'],
            ),
            ListTile(
              leading: Icon(Icons.text_fields, color: themeConfig['drawerIconColor']),
              title: Text('文本大小', style: TextStyle(color: themeConfig['textColor'])),
              trailing: DropdownButton(
                dropdownColor: themeConfig['backgroundColor'],
                icon: Icon(Icons.arrow_drop_down_rounded, color: themeConfig['drawerIconColor']),
                value: setFontSize,
                style: TextStyle(color: themeConfig['textColor']),
                items: fontSizeArray.map((String item) => DropdownMenuItem<String>(
                  key: Key(item),
                  value: item,
                  child: Text(item),
                )).toList(),
                onChanged: (value) async {
                  setState(() {
                    setFontSize = value!;
                  });
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString('setFontSize', setFontSize);
                },
                underline: Container(),
              ),
            ),
            ListTile(
              leading: Icon(Icons.outbox, color: /* themeConfig['drawerIconColor'] */ Colors.grey),
              title: Text("导出数据", style: TextStyle(color: /* themeConfig['textColor'] */ Colors.grey)),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('开发中'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.sd_card, color: /* themeConfig['drawerIconColor'] */ Colors.grey),
              title: Text("导入数据", style: TextStyle(color: /* themeConfig['textColor'] */ Colors.grey)),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('开发中'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info, color: themeConfig['drawerIconColor']),
              title: Text("关于", style: TextStyle(color: themeConfig['textColor'])),
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
