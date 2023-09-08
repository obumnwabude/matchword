import 'dart:convert';

import 'package:flutter/foundation.dart';

class MatchableSession {
  final String pro;
  final String contra;
  final Map<String, String> words;

  const MatchableSession(
      {required this.pro, required this.contra, required this.words});

  factory MatchableSession.fromMap(Map<String, dynamic> map) {
    return MatchableSession(
      pro: map['pro'],
      contra: map['contra'],
      words: Map<String, String>.from(map['words']),
    );
  }

  factory MatchableSession.fromJson(String source) =>
      MatchableSession.fromMap(json.decode(source));

  @override
  String toString() =>
      'MatchableSession(pro: $pro, contra: $contra, words: $words)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MatchableSession &&
        other.pro == pro &&
        other.contra == contra &&
        mapEquals(other.words, words);
  }

  @override
  int get hashCode => pro.hashCode ^ contra.hashCode ^ words.hashCode;

  static const sample = MatchableSession(
    pro: 'en',
    contra: 'lm',
    words: {'God': 'Nyuy', 'thank': 'beri', 'you': 'wo'},
  );
}
