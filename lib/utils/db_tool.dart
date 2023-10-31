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

// 数据库操作
class DatabaseHelper {
  Database? grammarDatabase;

  DatabaseHelper() {
    // initDb();
  }

  Future<Database> get dhGrammarDb async {
    if (grammarDatabase != null) {
      // print("????");
      return grammarDatabase!;
    } else {
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

  // TODO 导入导出
  Future<void> copyDataFromDatabase() async {
    var databasesPath = await getDatabasesPath();
    final sourceDatabase = await openDatabase(join(databasesPath, 'jlptgrammar.db'));
    final targetDatabase = await openDatabase(join("lib", "assets", "jlptgrammar.db"));
    final dataToCopy = await sourceDatabase.rawQuery('SELECT * FROM jlptgrammar');
    await targetDatabase.transaction((txn) async {
      for (var row in dataToCopy) {
        await txn.rawInsert(
            'INSERT INTO jlptgrammar (id, level, name, grammar, mean, example, notes) VALUES (?, ?, ?, ?, ?, ?, ?)',
            [row['id'], row['level'], row['name'], row['grammar'], row['mean'], row['example'], row['notes']]
        );
      }
    });
    await targetDatabase.close();
  }

  Future<void> resetDb() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'jlptgrammar.db');
    // 删除当前数据库文件
    await deleteDatabase(path);
    // 从assets目录中复制原始的数据库文件
    ByteData data = await rootBundle.load(join("lib", "assets", "jlptgrammar.db"));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(path).writeAsBytes(bytes);
    // 重新打开数据库
    var database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
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
    print("重置数据库: ${await database}");
  }

  Future<Database> initDb() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'jlptgrammar.db');
    await copyDatabase(path); // 等待复制数据库完成
    // var database = await openDatabase(path);
    var database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
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

    print("打开数据库: ${await database}");
    grammarDatabase = database;
    return database;
  }

  // TODO 导出数据库
  Future<void> exportDatabase() async {
    print("导出文件");
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
    await grammar.init();
    g.value = g.value + 1;
    print("添加了一条数据");
    return result;
  }

  // 更新数据
  Future<int> updateData(GrammarItem data) async {
    var dbClient = await dbHelper.dhGrammarDb;
    var result = await dbClient.update('jlptgrammar', data.toMap(),
        where: 'id = ?', whereArgs: [data.id]);
    await grammar.init();
    g.value = g.value + 1;
    print("更新了一条数据");
    return result;
  }

  // 删除数据
  Future<int> deleteData(int id) async {
    var dbClient = await dbHelper.dhGrammarDb;
    var result = await dbClient.delete('jlptgrammar', where: 'id = ?', whereArgs: [id]);
    await grammar.init();
    g.value = g.value - 1;
    print("删除了一条数据");
    return result;
  }

  // 获取特定 level
  Future<List<GrammarItem>> getLevelGrammarList(String tag) async {
    var dbClient = await dbHelper.dhGrammarDb;
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