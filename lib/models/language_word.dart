class LanguageWord {
  bool justFailed = false;
  bool justPassed = false;
  final String language;
  final String word;

  LanguageWord(this.language, this.word);

  @override
  String toString() => '$word ($language)';

  @override
  int get hashCode => language.hashCode ^ word.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is! LanguageWord) return false;
    return language == other.language && word == other.word;
  }
}
