class GrammarItem {
  final int? id;
  final String? level;
  final String? name;
  final String? grammar;
  final String? mean;
  final String? example;
  final String? notes;

  const GrammarItem({
    this.id,
    this.level,
    this.name,
    this.grammar,
    this.mean,
    this.example,
    this.notes,
  });

  factory GrammarItem.fromMap(Map<String, dynamic> json) => GrammarItem(
    id: json['id'],
    level: json['level'],
    name: json['name'],
    grammar: json['grammar'],
    mean: json['mean'],
    example: json['example'],
    notes: json['notes'],
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'level': level,
      'name': name,
      'grammar': grammar,
      'mean': mean,
      'example': example,
      'notes': notes,
    };
  }

  @override
  bool operator ==(other) {
    return other is GrammarItem &&
      other.id == id &&
      other.name == name &&
      other.level == level &&
      other.grammar == grammar &&
      other.mean == mean &&
      other.example == example &&
      other.notes == notes;
  }

  @override
  int get hashCode {
    return id.hashCode ^ level.hashCode ^ name.hashCode ^ grammar.hashCode ^ mean.hashCode ^ example.hashCode ^ notes.hashCode;
  }

}
