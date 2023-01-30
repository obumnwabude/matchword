import 'package:flutter/material.dart';

import 'word_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WordViewState wVState = WordViewState.inactive;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Match Words')),
      body: Center(
        child: WordView(
          onTap: () {
            setState(() {
              wVState = (WordViewState.values.toList()..shuffle()).first;
            });
          },
          state: wVState,
          word: 'Word',
        ),
      ),
    );
  }
}
