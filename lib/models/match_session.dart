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
    final Map<int, MapEntry<String, String>> indexToWords = {};
    for (int i = 0; i < starter.words.length; i++) {
      final wordPair = starter.words.entries.elementAt(i);
      if (first.column == starter.pro) {
        if (wordPair.key == first.word && wordPair.value == second.word) {
          indexToWords[i] = wordPair;
        }
      } else {
        if (wordPair.key == second.word && wordPair.value == first.word) {
          indexToWords[i] = wordPair;
        }
      }
    }
    for (var entry in indexToWords.entries) {
      if (!_recordingMatches[entry.key]!) {
        _recordingMatches[entry.key] = true;
        return true;
      }
    }
    return false;
  }

  static Map<WordInColumn, WordInColumn> _randomize(MatchableSession starter) {
    final random = Random();
    final proColumn = starter.words.keys.toList();
    final contraColumn = starter.words.values.toList();
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
