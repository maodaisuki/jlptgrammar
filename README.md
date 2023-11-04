<p align="center">
  <img width="140" height="140" src="https://github.com/maodaisuki/jlptgrammar/blob/main/doc/assets/icon.png?raw=true">
</p>
<h3 align="center">日本語文法</h3>
<p align="center">一款简洁的日本语文法应用</p>
<hr />

## 下载

### Android

* [从 Github Release 下载](https://github.com/maodaisuki/jlptgrammar/releases)



## 特性

<p align='center'>
    <img src="https://github.com/maodaisuki/jlptgrammar/blob/main/doc/assets/feature01.png?raw=true" />
    <img src="https://github.com/maodaisuki/jlptgrammar/blob/main/doc/assets/feature02.png?raw=true" />
    <img src="https://github.com/maodaisuki/jlptgrammar/blob/main/doc/assets/feature03.png?raw=true" />
    <img src="https://github.com/maodaisuki/jlptgrammar/blob/main/doc/assets/feature04.png?raw=true" />
    <img src="https://github.com/maodaisuki/jlptgrammar/blob/main/doc/assets/feature05.png?raw=true" />
    <img src="https://github.com/maodaisuki/jlptgrammar/blob/main/doc/assets/feature06.png?raw=true" />
    <img src="https://github.com/maodaisuki/jlptgrammar/blob/main/doc/assets/feature07.png?raw=true" />
    <img src="https://github.com/maodaisuki/jlptgrammar/blob/main/doc/assets/feature08.png?raw=true" />
</p>



## 编译

参考 [Flutter 文档](https://docs.flutter.dev/)。



## 数据存储相关

数据库存储用表创建语句为

```sql
CREATE TABLE "jlptgrammar" (
	"id"	INTEGER NOT NULL,
	"level"	TEXT,
	"name"	TEXT,
	"grammar"	TEXT,
	"mean"	TEXT,
	"example"	TEXT,
	"notes"	TEXT,
	PRIMARY KEY("id")
)
```



## 数据来源

软件内置数据来源于[毎日のんびり日本語教師](https://nihongonosensei.net/)。此**不作为**软件的一部分。

