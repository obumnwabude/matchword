import 'dart:math';

import 'package:flutter/material.dart';

import '../models/language_word.dart';
import '../models/match_session.dart';
import '../widgets/word_view.dart';

class SessionScreen extends StatefulWidget {
  final MatchSession session;
  const SessionScreen(this.session, {Key? key}) : super(key: key);

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  LanguageWord? _tapped;

  void _onTap(LanguageWord word) {
    setState(() {
      if (_tapped == null ||
          (_tapped!.language == word.language && _tapped != word)) {
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

  WordViewState _wVState(LanguageWord word) {
    if (word.justPassed) {
      Future.delayed(
        const Duration(seconds: 1),
        () => setState(() => word.justPassed = false),
      );
      return WordViewState.correct;
    } else if (word.justFailed) {
      Future.delayed(
        const Duration(seconds: 1),
        () => setState(() => word.justFailed = false),
      );
      return WordViewState.incorrect;
    } else if (widget.session.parent(word).isMatched) {
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
                ...widget.session.displayPairs
                    .map((pair) => [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              WordView(
                                word: pair.first,
                                state: _wVState(pair.first),
                                onTap: () => _onTap(pair.first),
                              ),
                              const SizedBox(width: 24),
                              WordView(
                                word: pair.second,
                                state: _wVState(pair.second),
                                onTap: () => _onTap(pair.second),
                              )
                            ],
                          ),
                          const SizedBox(height: 24),
                        ])
                    .expand((w) => w),
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
