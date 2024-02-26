import 'package:flutter/material.dart';
import 'view/game_screen.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GameScreen()),
            );
          },
          child: const Text('Start '),
        ),
      ),
    );
  }
}
