import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/game_bloc.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tic Tac Toe'),
          centerTitle: true,
        ),
        body: const GameView(),
      ),
    );
  }
}

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        if (state is GameInProgress) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Display player 1's name and score
                  Row(
                    children: [
                      Text(
                        'X',
                        style: TextStyle(color: Colors.purple, fontSize: 60),
                      ),
                      SizedBox(width: 10),
                      Column(
                        children: [
                          Text(
                            'Player 1',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            '0',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Display player 2's name and score
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'O',
                            style: TextStyle(color: Colors.green, fontSize: 60),
                          ),
                          SizedBox(width: 10),
                          Column(
                            children: [
                              Text(
                                'Player 2',
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                '0',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 5),
              // Draw the board
              SizedBox(
                height: 400,
                child: GridView.builder(
                  padding: const EdgeInsets.all(10.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    int row = index ~/ 3;
                    int col = index % 3;
                    return GestureDetector(
                      onTap: () =>
                          BlocProvider.of<GameBloc>(context).play(row, col),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            BlocProvider.of<GameBloc>(context).state.board[row]
                                [col],
                            style: TextStyle(
                              color: BlocProvider.of<GameBloc>(context)
                                          .state
                                          .board[row][col] ==
                                      'X'
                                  ? Colors.purple // Couleur pour X
                                  : BlocProvider.of<GameBloc>(context)
                                              .state
                                              .board[row][col] ==
                                          'O'
                                      ? Colors.green // Couleur pour O
                                      : Colors.black, // Couleur par défaut
                              fontSize: 60.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Display the result
              Container(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Player ${BlocProvider.of<GameBloc>(context).state.player} turn',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      BlocProvider.of<GameBloc>(context).state.result,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color:
                            BlocProvider.of<GameBloc>(context).state.result ==
                                    ''
                                ? Colors.transparent
                                : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),

              // Reset button
              Container(
                padding: const EdgeInsets.all(5.0),
                child: ElevatedButton(
                  onPressed: () => BlocProvider.of<GameBloc>(context).reset(),
                  child: const Text(
                    '  New Game  ',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () => BlocProvider.of<GameBloc>(context).reset(),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  child: const Text(
                    'Reset History',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return Container(); // Placeholder for other states
        }
      },
    );
  }
}
