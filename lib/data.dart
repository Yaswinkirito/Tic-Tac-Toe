import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameBoard {
  final List<List<String?>> board;
  final String currentPlayer;
  final String? winner;
  final bool gameOver;
  final bool firstGame;
  final int scoreX;
  final int scoreY;
  final int draws;
  GameBoard({
    required this.board,
    this.currentPlayer = "X",
    this.winner,
    this.gameOver = true,
    this.scoreX = 0,
    this.scoreY = 0,
    this.draws = 0,
    this.firstGame = true,
  });
}

class TicTactData extends Notifier<GameBoard> {
  @override
  GameBoard build() {
    return GameBoard(board: _nullboard());
  }

  void click(int index_1) {
    int row = (index_1 / 3).toInt();
    int col = index_1 % 3;
    if (state.gameOver == false) {
      List<List<String?>> newBoard = [
        for (int i = 0; i < 3; i++)
          [
            for (int j = 0; j < 3; j++)
              ((i == row) && (j == col) && (state.board[i][j] == null))
                  ? state.currentPlayer
                  : state.board[i][j],
          ],
      ];
      int x = state.scoreX;
      int o = state.scoreY;
      int draw = state.draws;
      String? winner = checkwin(newBoard);
      if (winner == "X") {
        x++;
      } else if (winner == "O") {
        o++;
      } else if (winner == "draw") {
        draw++;
      }
      state = GameBoard(
        board: newBoard,
        currentPlayer: (state.currentPlayer == "X" ? "O" : "X"),
        winner: winner,
        gameOver: (winner != null) ? true : false,
        scoreX: x,
        scoreY: o,
        draws: draw,
        firstGame: false,
      );
      print(winner);
    }
  }

  void reset() {
    int x = state.scoreX;
    int y = state.scoreY;
    int draw = state.draws;
    state = GameBoard(
      board: _nullboard(),
      gameOver: false,
      scoreX: x,
      scoreY: y,
      draws: draw,
      winner: null,
      firstGame: false,
    );
  }

  List<List<String?>> _nullboard() {
    return [
      [null, null, null],
      [null, null, null],
      [null, null, null],
    ];
  }

  String? checkwin(List<List<String?>> board) {
    bool draw = true;
    if ((board[1][1] != null) &&
        (((board[0][0] == board[1][1]) && (board[1][1] == board[2][2])) ||
            ((board[0][2] == board[1][1]) && (board[1][1] == board[2][0])))) {
      return board[1][1];
    }

    for (int i = 0; i < 3; i++) {
      if ((board[i][0] != null) &&
          (board[i][0] == board[i][1]) &&
          (board[i][1] == board[i][2])) {
        return board[i][0];
      }
      if ((board[0][i] != null) &&
          (board[0][i] == board[1][i]) &&
          (board[1][i] == board[2][i])) {
        return board[0][i];
      }
      if (board[i].contains(null)) {
        draw = false;
      }
    }
    if (draw) {
      return "draw";
    }
    return null;
  }
}

final ticTactDataProvider = NotifierProvider<TicTactData, GameBoard>(() {
  return TicTactData();
});
