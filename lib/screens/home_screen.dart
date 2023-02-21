import 'package:flutter/material.dart';

import '../models/language_word.dart';
import '../models/match_session.dart';
import '../models/word_pair.dart';
import 'session_screen.dart';

class HomeScreen extends StatelessWidget {
  final _session = MatchSession([
    WordPair(LanguageWord('eng', 'Thanks'), LanguageWord('lam', 'Beri')),
    WordPair(LanguageWord('eng', 'you'), LanguageWord('lam', 'wo')),
    WordPair(LanguageWord('eng', 'God'), LanguageWord('lam', 'Nyuy'))
  ]);

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Match Words')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Start'),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => SessionScreen(_session)),
          ),
        ),
      ),
    );
  }
}
