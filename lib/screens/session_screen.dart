import 'dart:math';

import 'package:flutter/material.dart';

import '../models/match_session.dart';
import '../models/word_in_column.dart';
import '../widgets/word_view.dart';

class SessionScreen extends StatefulWidget {
  final MatchSession session;
  const SessionScreen(this.session, {super.key});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  WordInColumn? _tapped;

  void _onTap(WordInColumn word) {
    setState(() {
      if (_tapped == null ||
          (_tapped!.column == word.column && _tapped != word)) {
        _tapped = word;
      } else {
        if (_tapped != word) {
          if (widget.session.match(_tapped!, word)) {
            _tapped!.justPassed = true;
            word.justPassed = true;
          } else {
            _tapped!.justFailed = true;
            word.justFailed = true;
          }
        }
        _tapped = null;
      }
    });
  }

  WordViewState _wVState(WordInColumn word) {
    if (word.justPassed) {
      Future.delayed(
        const Duration(seconds: 1),
        () {
          if (mounted) {
            setState(() {
              word.hasMatched = true;
              word.justPassed = false;
            });
          }
        },
      );
      return WordViewState.correct;
    } else if (word.justFailed) {
      Future.delayed(
        const Duration(seconds: 1),
        () {
          if (mounted) setState(() => word.justFailed = false);
        },
      );
      return WordViewState.incorrect;
    } else if (word.hasMatched) {
      return WordViewState.matched;
    } else if (_tapped != null && _tapped == word) {
      return WordViewState.selected;
    } else {
      return WordViewState.inactive;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Match Words')),
      body: Center(
        child: SizedBox(
          width: min(384, MediaQuery.of(context).size.width),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...widget.session.randomized.entries.map((pair) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WordView(
                          word: pair.key,
                          state: _wVState(pair.key),
                          onTap: () => _onTap(pair.key),
                        ),
                        const SizedBox(width: 24),
                        WordView(
                          word: pair.value,
                          state: _wVState(pair.value),
                          onTap: () => _onTap(pair.value),
                        )
                      ],
                    ),
                  );
                }),
                if (widget.session.isComplete) ...[
                  const SizedBox(height: 40),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Done'),
                    )
                  ])
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
