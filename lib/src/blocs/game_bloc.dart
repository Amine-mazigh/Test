import 'package:flutter_bloc/flutter_bloc.dart';

abstract class GameState {
  List<List<String>> get board;
  String get player;
  String get result;
}

class GameInProgress extends GameState {
  @override
  final List<List<String>> board;
  @override
  final String player;
  @override
  final String result;
  GameInProgress(this.board, this.player, this.result);
}

class GameOver extends GameState {
  @override
  final String result;
  GameOver(this.result);

  @override
  List<List<String>> get board => const [];

  @override
  String get player => '';
}

class GameBloc extends Cubit<GameState> {
  List<List<String>> _board = [
    ['', '', ''],
    ['', '', ''],
    ['', '', ''],
  ];

  String _player = 'X';
  String _result = '';
  int player1Wins = 0;
  int player2Wins = 0;

  GameBloc()
      : super(GameInProgress([
          ['', '', ''],
          ['', '', ''],
          ['', '', '']
        ], 'X', ''));

  void play(int row, int col) {
    if (state is! GameInProgress) return;

    if (_board[row][col] == '') {
      _board[row][col] = _player;
      _checkWin();
      if (state is! GameOver) {
        _player = _player == 'X' ? 'O' : 'X';
        emit(GameInProgress(_board, _player, _result));
      }
    }
  }

  void reset() {
    _board = [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ];
    _player = 'X';
   
    emit(GameInProgress(_board, _player, _result));
  }

  void _checkWin() {
    for (int i = 0; i < 3; i++) {
      if (_board[i][0] == _board[i][1] &&
          _board[i][1] == _board[i][2] &&
          _board[i][0] != '') {
        _result = '${_board[i][0]} , you win !';
        return;
      }
      if (_board[0][i] == _board[1][i] &&
          _board[1][i] == _board[2][i] &&
          _board[0][i] != '') {
        _result = '${_board[0][i]} , you win !';
        return;
      }
    }
    if (_board[0][0] == _board[1][1] &&
        _board[1][1] == _board[2][2] &&
        _board[0][0] != '') {
      _result = '${_board[0][0]} , you win !';
      return;
    }
    if (_board[0][2] == _board[1][1] &&
        _board[1][1] == _board[2][0] &&
        _board[0][2] != '') {
      _result = '${_board[0][2]} , you win !';
      return;
    }
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (_board[i][j] == '') {
          return;
        }
      }
    }
    _result = 'Draw!';
    if (_result.contains('X')) {
    player1Wins++;
  } else if (_result.contains('O')) {
    player2Wins++;
  }
    emit(GameOver(_result));
  }
}
