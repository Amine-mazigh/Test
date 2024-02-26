import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/blocs/game_bloc.dart';
import 'src/view/game_screen.dart';

void main() {
  runApp(MaterialApp(
    home: BlocProvider(
      create: (context) => GameBloc(),
      child: const GameScreen(),
    ),
  ));
}
