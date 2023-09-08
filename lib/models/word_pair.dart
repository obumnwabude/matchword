import 'word_in_column.dart';

class WordPair {
  bool isMatched = false;
  final WordInColumn first;
  final WordInColumn second;

  WordPair(this.first, this.second);

  @override
  String toString() => '$first - $second';

  bool contains(WordInColumn word) => word == first || word == second;
}
