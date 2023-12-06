import 'package:jlptgrammar/models/grammar_item_model.dart';
import 'dart:math';
import 'package:jlptgrammar/common/global.dart';

class QuizGenerator {
  GrammarItem randomListItem() {
    final random = new Random();
    final item = grammar.grammarList[random.nextInt(grammar.grammarList.length)];
    return item;
  }
}
