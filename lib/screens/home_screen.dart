import 'package:flutter/material.dart';
import 'package:matchwords/models/matchable_session.dart';

import '../models/match_session.dart';
import 'session_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Match Words')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Start'),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => SessionScreen(
                MatchSession(MatchableSession.sample),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
