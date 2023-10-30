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
      child: Container(
      width: MediaQuery.of(context).size.width * 3.5 / 5,
        child: Drawer(
          backgroundColor: themeConfig['backgroundColor'],
          child: ListView(
            // TODO 添加条目
            children: [
              Container(
                margin: EdgeInsets.only(left: 0),
                height: 70,
                child: ListTile(
                  title: Text(
                    '日本語文法',
                    style: TextStyle(
                    fontSize: 20,
                    color: themeConfig['textColor'],
                  )),
                  trailing: IconButton(
                    icon: Icon(Icons.settings, color: themeConfig['drawerIconColor']),
                    onPressed: () {
                      Scaffold.of(context).closeDrawer();
                      Navigator.of(context).pushNamed('/settings');
                    },
                  ),
                ),
              ),
              Divider(
                height: 0.5,
                indent: 0,
                color: Colors.transparent,
              ),
              Container(
                height: 20,
                margin: EdgeInsets.only(left: 20, bottom: 10),
                child: Text(
                  '分类',
                  style: TextStyle(
                    fontSize: 15,
                    color: themeConfig['drawerTitleColor'],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: ListTile(
                  title: Text('JLPT N5', style: TextStyle(color: themeConfig['textColor'], fontSize: 18)),
                  shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  leading: Icon(Icons.book, color: themeConfig['drawerIconColor']),
                  onTap: () {
                    // 关闭抽屉
                    Scaffold.of(context).closeDrawer();
                    Navigator.of(context).pushNamed('/n5');
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: ListTile(
                  title: Text('JLPT N4', style: TextStyle(color: themeConfig['textColor'], fontSize: 18)),
                  shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  leading: Icon(Icons.book, color: themeConfig['drawerIconColor']),
                  onTap: () {
                    // 关闭抽屉
                    Scaffold.of(context).closeDrawer();
                    Navigator.of(context).pushNamed('/n4');
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: ListTile(
                  title: Text('JLPT N3', style: TextStyle(color: themeConfig['textColor'], fontSize: 18)),
                  shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  leading: Icon(Icons.book, color: themeConfig['drawerIconColor']),
                  onTap: () {
                    // 关闭抽屉
                    Scaffold.of(context).closeDrawer();
                    Navigator.of(context).pushNamed('/n3');
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: ListTile(
                  title: Text('JLPT N2', style: TextStyle(color: themeConfig['textColor'], fontSize: 18)),
                  shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  leading: Icon(Icons.book, color: themeConfig['drawerIconColor']),
                  onTap: () {
                    // 关闭抽屉
                    Scaffold.of(context).closeDrawer();
                    Navigator.of(context).pushNamed('/n2');
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: ListTile(
                  title: Text('JLPT N1', style: TextStyle(color: themeConfig['textColor'], fontSize: 18)),
                  shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  leading: Icon(Icons.book, color: themeConfig['drawerIconColor']),
                  onTap: () {
                    // 关闭抽屉
                    Scaffold.of(context).closeDrawer();
                    Navigator.of(context).pushNamed('/n1');
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: ListTile(
                  title: Text('其他文法', style: TextStyle(color: themeConfig['textColor'], fontSize: 18)),
                  shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  leading: Icon(Icons.book, color: themeConfig['drawerIconColor']),
                  onTap: () {
                    // 关闭抽屉
                    Scaffold.of(context).closeDrawer();
                    Navigator.of(context).pushNamed('/n0');
                  },
                ),
              ),
              Container(
                height: 20,
                margin: EdgeInsets.only(left: 20, bottom: 10, top: 15),
                child: Text(
                  '其他选项',
                  style: TextStyle(
                    fontSize: 15,
                    color: themeConfig['drawerTitleColor'],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: ListTile(
                  title: Text('练习题', style: TextStyle(color: themeConfig['textColor'], fontSize: 18)),
                  shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  leading: Icon(Icons.library_books, color: themeConfig['drawerIconColor']),
                  onTap: () {
                    Scaffold.of(context).closeDrawer();
                    Navigator.of(context).pushNamed('/exercises');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
