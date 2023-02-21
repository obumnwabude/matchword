import 'dart:math';

import 'language_word.dart';
import 'word_pair.dart';

class MatchSession {
  static List<WordPair> _randomize(List<WordPair> wordPairs) {
    if (wordPairs.length < 2) return wordPairs;

    final random = Random();
    final firstWords = [], secondWords = [];
    final List<WordPair> randomizedPairs = [];

    for (final pair in wordPairs) {
      firstWords.add(pair.first);
      secondWords.add(pair.second);
    }

    while (firstWords.isNotEmpty) {
      randomizedPairs.add(
        WordPair(
          firstWords.removeAt(0),
          secondWords.removeAt(random.nextInt(secondWords.length)),
        ),
      );
    }

    return randomizedPairs;
  }

  final List<WordPair> correctPairs;
  final List<WordPair> displayPairs;

  MatchSession(this.correctPairs) : displayPairs = _randomize(correctPairs);

  bool get isComplete => correctPairs.every((pair) => pair.isMatched);

  bool match(LanguageWord first, LanguageWord second) {
    final index = correctPairs
        .indexWhere((pair) => pair.contains(first) && pair.contains(second));

    if (index == -1) return false;
    correctPairs[index].isMatched = true;
    return true;
  }

  WordPair parent(LanguageWord word) =>
      correctPairs.firstWhere((pair) => pair.contains(word));
}
