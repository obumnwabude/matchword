class WordInColumn {
  bool hasMatched = false;
  bool justFailed = false;
  bool justPassed = false;
  final String column;
  final String word;

  WordInColumn(this.column, this.word);

  @override
  String toString() => '$word ($column)';
}
