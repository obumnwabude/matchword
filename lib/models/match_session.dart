import 'dart:math';

import 'matchable_session.dart';
import 'word_in_column.dart';

class MatchSession {
  MatchSession(this.starter)
      : randomized = _randomize(starter),
        _recordingMatches = {
          for (int i = 0; i < starter.words.length; i++) i: false
        };

  final Map<WordInColumn, WordInColumn> randomized;
  final Map<int, bool> _recordingMatches;
  final MatchableSession starter;

  bool get isComplete => !_recordingMatches.containsValue(false);

  bool match(WordInColumn first, WordInColumn second) {
    for (int i = 0; i < starter.words.length; i++) {
      final pair = starter.words[i];
      if ((pair[first.word] == second.word ||
              pair[second.word] == first.word) &&
          !(_recordingMatches[i] ?? false)) {
        _recordingMatches[i] = true;
        return true;
      }
    }
    return false;
  }

  static Map<WordInColumn, WordInColumn> _randomize(MatchableSession starter) {
    final random = Random();
    final proColumn = [];
    final contraColumn = [];
    for (final pair in starter.words) {
      if (pair.entries.isEmpty) continue;
      final MapEntry(:key, :value) = pair.entries.first;
      proColumn.add(key);
      contraColumn.add(value);
    }
    final Map<WordInColumn, WordInColumn> randomized = {};

    while (proColumn.isNotEmpty) {
      final proWord = WordInColumn(
          starter.pro, proColumn.removeAt(random.nextInt(proColumn.length)));
      final contraWord = WordInColumn(starter.contra,
          contraColumn.removeAt(random.nextInt(contraColumn.length)));
      randomized[proWord] = contraWord;
    }

    return randomized;
  }
}
