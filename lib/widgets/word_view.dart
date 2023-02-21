import 'package:flutter/material.dart';

import '../models/language_word.dart';

enum WordViewState { inactive, selected, correct, incorrect, matched }

class WordView extends StatelessWidget {
  final LanguageWord word;
  final WordViewState state;
  final VoidCallback onTap;

  const WordView({
    super.key,
    required this.word,
    required this.state,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = _colorForState(state, Theme.of(context).brightness);

    return Expanded(
      child: AnimatedContainer(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(milliseconds: 300),
        child: Container(
          margin: const EdgeInsets.fromLTRB(2, 2, 2, 6),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              splashColor: color,
              onTap: state != WordViewState.matched ? onTap : null,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                child: Text(
                  word.word,
                  style: TextStyle(color: color, height: 1),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _colorForState(WordViewState state, Brightness mode) {
    final darkGrey = Colors.grey.shade700;
    final lightGrey = Colors.grey.shade400;

    switch (state) {
      case WordViewState.inactive:
        return mode == Brightness.light ? darkGrey : lightGrey;
      case WordViewState.selected:
        return Colors.blue.shade700;
      case WordViewState.correct:
        return Colors.green.shade700;
      case WordViewState.incorrect:
        return Colors.red.shade700;
      case WordViewState.matched:
        return mode == Brightness.light ? lightGrey : darkGrey;
    }
  }
}
