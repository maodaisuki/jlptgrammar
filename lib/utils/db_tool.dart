import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:jlptgrammar/models/grammar_item_model.dart';
import 'package:jlptgrammar/utils/permission_tool.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:jlptgrammar/common/global.dart';
import 'package:path/path.dart' as path_tool;

// 数据库操作
class DatabaseHelper {
  Database? grammarDatabase;

  DatabaseHelper() {
    //
  }

  Future<Database> get dhGrammarDb async {
    if (grammarDatabase != null) {
      // print("????");
      return grammarDatabase!;
    } else {
      print("准备初始化数据库");
      grammarDatabase = await initDb();
      return grammarDatabase!;
    }
  }

  Future<void> copyDatabase(String path) async {
    if (await databaseExists(path)) {
      return;
    }
    // 项目数据库文件位置 /lib/assets/jlptgrammar.db
    ByteData data = await rootBundle.load(join("lib", "assets", "jlptgrammar.db"));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(path).writeAsBytes(bytes);
  }

  Future<Database> initDb() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'jlptgrammar.db');
    await copyDatabase(path); // 等待复制数据库完成
    // var database = await openDatabase(path);
    var database = await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
            CREATE TABLE IF NOT EXISTS jlptgrammar (
              id INTEGER PRIMARY KEY NOT NULL,
              level TEXT,
              name TEXT,
              grammar TEXT,
              mean TEXT,
              example TEXT,
              notes TEXT
            )
          ''');
    });
    print("打开数据库 initDb: ${await database}");
    return database;
  }

  Future<void> resetDb() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'jlptgrammar.db');
    // 删除当前数据库文件
    await close();
    await deleteDatabase(path);
    // 从assets目录中复制原始的数据库文件
    ByteData data = await rootBundle.load(join("lib", "assets", "jlptgrammar.db"));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(path).writeAsBytes(bytes);
    // 重新打开数据库
    var database = await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE IF NOT EXISTS jlptgrammar (
            id INTEGER PRIMARY KEY NOT NULL,
            level TEXT,
            name TEXT,
            grammar TEXT,
            mean TEXT,
            example TEXT,
            notes TEXT
          )
        ''');
    });
    grammarDatabase = database;
    print("重置数据库: $database");
  }

  Future<bool> checkDatabase(String path) async {
    String tableName = 'jlptgrammar';
    List<String> columnNameList = ['id', 'level', 'name', 'grammar', 'mean', 'example', 'notes'];
    Database db = await openDatabase(path);
    List<Map<String, dynamic>> tables =
        await db.rawQuery('SELECT name FROM sqlite_master WHERE type="table" AND name="$tableName"');
    if (tables.isNotEmpty) {
      List<Map<String, dynamic>> columns = await db.rawQuery('PRAGMA table_info($tableName)');
      // for(var column in columns) {
      //   print(column['name']);
      // }
      bool isColumnExists = columnNameList.every((columnName) => columns.any((column) => column['name'] == columnName));
      // print("isColumnExists = $isColumnExists");
      // await db.close();
      if (isColumnExists) {
        return true;
      } else {
        return false;
      }
    } else {
      print("文件为空");
      await db.close();
      return false;
    }
  }

  Future<bool> importDatabase(String importPath) async {
    if (path_tool.extension(importPath) == '.db') {
      // var databasePath = await getDatabasesPath();
      // var path = join(databasePath, 'jlptgrammar.db');
      var path = grammar.grammardb.path;
      // 检查 db 文件合法性
      await close();
      if (await checkDatabase(importPath)) {
        print("暂时关闭数据库");
        try {
          RandomAccessFile file = await File(path).open(mode: FileMode.write);
          await file.truncate(0);
          await file.close();
          var data = await File(importPath).readAsBytes();
          // print(data);
          await File(path).writeAsBytes(data);
          return true;
        } catch (e) {
          print(e);
          return false;
        } finally {
          print("重启数据库");
          try {
            grammar = Grammar();
          } catch (e) {
            print(e);
          }
        }
      } else {
        print("文件数据错误");
        return false;
      }
    } else {
      print("文件类型错误");
      return false;
    }
  }

  Future<bool> exportDatabase(String exportPath) async {
    // 关闭当前对象后再读取
    print("暂时关闭数据库");
    await close();
    final timeName = DateTime.now().toString();
    exportPath = '$exportPath/jlptgrammar_export_$timeName.db';
    // var databasesPath = await getDatabasesPath();
    var sourcePath = grammar.grammardb.path;
    // print(await File(sourcePath).exists() ? "存在此源文件" : "源文件不存在");
    // print("exportPath: $exportPath");
    // print("sourcePath: $sourcePath");
    try {
      var data = await File(sourcePath).readAsBytes();
      // print(data);
      await File(exportPath).writeAsBytes(data);
      return true;
    } catch (e) {
      print(e);
      return false;
    } finally {
      print("重启数据库");
      try {
        grammar = Grammar();
      } catch (e) {
        print(e);
      }
    }
  }

  // 关闭数据库连接
  Future close() async {
    var dbClient = await dhGrammarDb;
    await dbClient.close();
    print("关闭数据库连接");
    return;
  }
}

// 数据库外部函数
class DatabaseTool {
  final DatabaseHelper dbHelper = DatabaseHelper();

  // 插入数据
  Future<int> insertData(GrammarItem data) async {
    var dbClient = await dbHelper.dhGrammarDb;
    var result = await dbClient.insert('jlptgrammar', data.toMap());
    // 刷新数据
    grammar = Grammar();
    g.value = g.value + 1;
    print("添加了一条数据");
    return result;
  }

  // 更新数据
  Future<int> updateData(GrammarItem data) async {
    var dbClient = await dbHelper.dhGrammarDb;
    var result = await dbClient.update('jlptgrammar', data.toMap(), where: 'id = ?', whereArgs: [data.id]);
    grammar = Grammar();
    g.value = g.value + 1;
    print("更新了一条数据");
    return result;
  }

  // 删除数据
  Future<int> deleteData(int id) async {
    var dbClient = await dbHelper.dhGrammarDb;
    var result = await dbClient.delete('jlptgrammar', where: 'id = ?', whereArgs: [id]);
    grammar = Grammar();
    g.value = g.value - 1;
    print("删除了一条数据");
    return result;
  }

  // 获取特定 level
  Future<List<GrammarItem>> getLevelGrammarList(String tag, Database db) async {
    var dbClient = db;
    var result = await dbClient.rawQuery("SELECT * FROM jlptgrammar WHERE level == ?", [tag]);
    return result.map((map) => GrammarItem.fromMap(map)).toList();
  }

  // 获取所有数据
  Future<List<GrammarItem>> getAllData() async {
    var dbClient = await dbHelper.dhGrammarDb;
    var result = await dbClient.rawQuery('SELECT * FROM jlptgrammar');
    return result.map((map) => GrammarItem.fromMap(map)).toList();
  }
}
