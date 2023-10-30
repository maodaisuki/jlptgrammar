import 'package:flutter/material.dart';
import 'package:jlptgrammar/models/grammar_item_model.dart';
import 'package:jlptgrammar/utils/db_tool.dart';
import 'package:jlptgrammar/common/global.dart';

class TextTool {
  GrammarItem insertDataGenerator(TextEditingController t1, TextEditingController t2, TextEditingController t3, TextEditingController t4, TextEditingController t5, String setLevel) {
    if(setLevel == "其他") {
      setLevel = 'N0';
    }
    else if(setLevel == '方言') {
      setLevel = 'N6';
    }
    else {
      //
    }

    GrammarItem temp = GrammarItem(
      level: setLevel,
      name: t1.text,
      grammar: t2.text,
      mean: t3.text,
      example: t4.text,
      notes: t5.text,
    );



    return temp;
  }

  GrammarItem updateDataGenerator(int id, TextEditingController t1, TextEditingController t2, TextEditingController t3, TextEditingController t4, TextEditingController t5) {
    GrammarItem temp = GrammarItem(
      id: id,
      name: t1.text,
      grammar: t2.text,
      mean: t3.text,
      example: t4.text,
      notes: t5.text,
    );
    return temp;
  }
}