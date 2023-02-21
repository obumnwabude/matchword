import 'package:flutter/material.dart';

enum WordViewState { inactive, selected, correct, incorrect }

class WordView extends StatelessWidget {
  final String word;
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
    final color = _colorForState(state);

    return AnimatedContainer(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      duration: const Duration(milliseconds: 300),
      child: Container(
        margin: const EdgeInsets.fromLTRB(2, 2, 2, 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            splashColor: color,
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                word,
                style: TextStyle(color: color),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _colorForState(WordViewState state) {
    switch (state) {
      case WordViewState.inactive:
        return Colors.grey;
      case WordViewState.selected:
        return Colors.blue;
      case WordViewState.correct:
        return Colors.green;
      case WordViewState.incorrect:
        return Colors.red;
    }
  }
}
