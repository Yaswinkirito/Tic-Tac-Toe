import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/components.dart';
import 'package:tic_tac_toe/data.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic-Tac-Toe',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0XFF2B0040),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: TicTacToe(),
    );
  }
}

class TicTacToe extends ConsumerWidget {
  const TicTacToe({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameBoard = ref.watch(ticTactDataProvider);

    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            gameBoard.gameOver
                ? Text("Game Over! Winner is ${gameBoard.winner}")
                : Text("Player ${gameBoard.currentPlayer}'s move"),
            SizedBox(
              height: height * (142 / 1257),
              width: height * (512 / 1257),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ScoreBox(
                    height: height,
                    boxColor: Color(0XFF48D2FE),
                    value: gameBoard.scoreX,
                    title: "PLAYER X",
                  ),
                  ScoreBox(
                    height: height,
                    boxColor: Color(0XFFBCDBF9),
                    value: gameBoard.draws,
                    title: "DRAW",
                  ),
                  ScoreBox(
                    height: height,
                    boxColor: Color(0XFFE2BE00),
                    value: gameBoard.scoreY,
                    title: "PLAYER O",
                  ),
                ],
              ),
            ),
            SizedBox(height: (40 / 1257) * height),
            SizedBox(
              width: (574 / 1257) * height,
              height: (574 / 1257) * height,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return Center(
                    child: GestureDetector(
                      child: Cell(
                        playerIcon: textToIcon(
                          gameBoard.board[(index / 3).toInt()][index % 3],
                          height,
                        ),
                        height: height,
                      ),
                      onTap: () {
                        ref.read(ticTactDataProvider.notifier).click(index);
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: (72 / 1257) * height),
            TurnBox(
              visibility: !gameBoard.firstGame,
              text: gameBoard.gameOver
                  ? (gameBoard.winner != "draw"
                        ? "${gameBoard.winner?.toUpperCase()} wins"
                        : "Game over its a Draw!")
                  : "${gameBoard.currentPlayer.toUpperCase()} turn",
              color: gameBoard.gameOver
                  ? Color(0XFF099C3B)
                  : (gameBoard.currentPlayer == "X"
                        ? Color(0XFF48D2FE)
                        : Color(0XFFE2BE00)),
              height: height,
            ),
            NewGame(height: height, ref: ref, gameOver: gameBoard.gameOver),
          ],
        ),
      ),
    );
  }

  Icon textToIcon(String? value, double height) {
    if (value == "O") {
      return Icon(
        Icons.circle_outlined,
        color: Color(0XFFE2BE00),
        size: height * (51 / 1257),
        fontWeight: FontWeight.w800,
      );
    } else if (value == "X") {
      return Icon(
        Icons.close,
        color: Color(0XFF48D2FE),
        size: height * (51 / 1257),
        fontWeight: FontWeight.w800,
      );
    }
    return Icon(Icons.clear, color: Colors.transparent);
  }
}
