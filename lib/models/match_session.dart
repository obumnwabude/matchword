import 'dart:math';

import 'word_in_column.dart';

typedef ColumnPair = ({WordInColumn pro, WordInColumn contra});

class MatchSession {
  MatchSession({required this.pro, required this.contra, required this.words})
      : matches = {for (int i = 0; i < words.length; i++) i: false};

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
  final List<Map<String, String>> words;
  final _random = Random();

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

  List<ColumnPair> next([count = 1]) {
    if (isComplete) throw 'Matches Completed';
    final List<Map<String, String>> pairs = [];
    for (final entry in matches.entries) {
      if (entry.value) continue;
      pairs.add(words[entry.key]);
      if (pairs.length == count) break;
    }
    return _randomize(pairs);
  }

  List<ColumnPair> _randomize(List<Map<String, String>> pairs) {
    final proColumn = [];
    final contraColumn = [];
    for (final pair in pairs) {
      if (pair.entries.isEmpty) continue;
      final MapEntry(:key, :value) = pair.entries.first;
      proColumn.add(key);
      contraColumn.add(value);
    }
    final List<ColumnPair> randomized = [];

    while (proColumn.isNotEmpty) {
      final proWord = WordInColumn(
          pro, proColumn.removeAt(_random.nextInt(proColumn.length)));
      final contraWord = WordInColumn(
          contra, contraColumn.removeAt(_random.nextInt(contraColumn.length)));
      randomized.add((pro: proWord, contra: contraWord));
    }

    return randomized;
  }
}
