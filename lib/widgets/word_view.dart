import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/word_in_column.dart';

enum WordViewState { inactive, selected, correct, incorrect, matched }

class WordView extends StatelessWidget {
  final WordInColumn word;
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
          borderRadius: BorderRadius.circular(12.r),
        ),
        duration: const Duration(milliseconds: 500),
        child: Container(
          margin: EdgeInsets.fromLTRB(2.r, 2.r, 2.r, 6.r),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8.r),
              splashColor: color,
              onTap: state != WordViewState.matched ? onTap : null,
              child: Padding(
                padding: EdgeInsets.fromLTRB(2.r, 16.r, 8.r, 16.r),
                child: Text(
                  word.word,
                  style: TextStyle(
                    color: color,
                    height: 1,
                    fontSize: 16.sp,
                    letterSpacing: 0.4,
                  ),
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
