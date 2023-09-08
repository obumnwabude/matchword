class WordInColumn {
  bool hasMatched = false;
  bool justFailed = false;
  bool justPassed = false;
  final String column;
  final String word;

  WordInColumn(this.column, this.word);

  @override
  String toString() => '$word ($column)';

  @override
  int get hashCode => column.hashCode ^ word.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is! WordInColumn) return false;
    return column == other.column && word == other.word;
  }
}
