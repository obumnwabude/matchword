import 'language_word.dart';

class WordPair {
  bool isMatched = false;
  final LanguageWord first;
  final LanguageWord second;

  WordPair(this.first, this.second);

  @override
  String toString() => '$first - $second';

  bool contains(LanguageWord word) => word == first || word == second;
}
