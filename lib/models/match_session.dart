import 'dart:math';

import 'word_in_column.dart';

class MatchSession {
  MatchSession({required this.pro, required this.contra, required this.words})
      : randomized = _randomize(pro, contra, words),
        matches = {for (int i = 0; i < words.length; i++) i: false};

  factory MatchSession.fromMap(Map<String, dynamic> matchable) {
    return MatchSession(
      pro: matchable['pro'],
      contra: matchable['contra'],
      words: matchable['words'],
    );
  }

  static final sample = MatchSession.fromMap({
    'pro': 'en',
    'contra': 'lm',
    'words': [
      {'God': 'Nyuy'},
      {'thank': 'beri'},
      {'you': 'wo'},
      {'God': 'Nyuy'},
      {'thank': 'beri'},
      {'you': 'wo'}
    ]
  });

  final String contra;
  final Map<int, bool> matches;
  final String pro;
  final Map<WordInColumn, WordInColumn> randomized;
  final List<Map<String, String>> words;

  bool get isComplete => !matches.containsValue(false);

  bool match(WordInColumn first, WordInColumn second) {
    for (int i = 0; i < words.length; i++) {
      final pair = words[i];
      if ((pair[first.word] == second.word ||
              pair[second.word] == first.word) &&
          !(matches[i] ?? false)) {
        matches[i] = true;
        return true;
      }
    }
    return false;
  }

  static Map<WordInColumn, WordInColumn> _randomize(
      String pro, String contra, List<Map<String, String>> words) {
    final random = Random();
    final proColumn = [];
    final contraColumn = [];
    for (final pair in words) {
      if (pair.entries.isEmpty) continue;
      final MapEntry(:key, :value) = pair.entries.first;
      proColumn.add(key);
      contraColumn.add(value);
    }
    final Map<WordInColumn, WordInColumn> randomized = {};

    while (proColumn.isNotEmpty) {
      final proWord = WordInColumn(
          pro, proColumn.removeAt(random.nextInt(proColumn.length)));
      final contraWord = WordInColumn(
          contra, contraColumn.removeAt(random.nextInt(contraColumn.length)));
      randomized[proWord] = contraWord;
    }

    return randomized;
  }
}
