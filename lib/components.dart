import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/data.dart';
import 'package:google_fonts/google_fonts.dart';

class Cell extends StatefulWidget {
  final Icon playerIcon;
  final double height;
  const Cell({super.key, required this.playerIcon, required this.height});

  @override
  State<Cell> createState() => _CellState();
}

class _CellState extends State<Cell> {
  bool hover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          hover = true;
        });
      },
      onExit: (event) {
        setState(() {
          hover = false;
        });
      },
      child: Container(
        padding: EdgeInsets.all((28 / 1257) * widget.height),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: hover ? Color(0xFF5A1E76) : Color(0xFF43115B),
        ),
        width: (150 / 1257) * widget.height,
        height: (150 / 1257) * widget.height,
        child: widget.playerIcon,
      ),
    );
  }
}

class NewGame extends StatelessWidget {
  const NewGame({
    super.key,
    required this.height,
    required this.ref,
    required this.gameOver,
  });

  final double height;
  final WidgetRef ref;
  final bool gameOver;

  @override
  Widget build(BuildContext context) {
    if (gameOver) {
      return Padding(
        padding: EdgeInsetsGeometry.fromLTRB(0, (100 / 1257) * height, 0, 0),
        child: GestureDetector(
          onTap: ref.read(ticTactDataProvider.notifier).reset,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            height: (111 / 1257) * height,
            width: (624 / 1257) * height,
            child: Center(child: Text("New Game")),
          ),
        ),
      );
    }
    return Container();
  }
}

class ScoreBox extends StatelessWidget {
  final double height;
  final Color boxColor;
  final int value;
  final String title;
  const ScoreBox({
    super.key,
    required this.height,
    required this.boxColor,
    required this.value,
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: boxColor,
      ),
      width: (160 / 1257) * height,
      height: (158 / 1257) * height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsetsGeometry.fromLTRB(
              (14.5 / 1257) * height,
              (14.5 / 1257) * height,
              (14.5 / 1257) * height,
              (4 / 1257) * height,
            ),
            child: Text(
              title,
              style: GoogleFonts.fredoka(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.fromLTRB(
              (15 / 1257) * height,
              0,
              (15 / 1257) * height,
              (17.5 / 1257) * height,
            ),
            child: Text(
              value.toString(),
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TurnBox extends StatelessWidget {
  final bool visibility;
  final String text;
  final Color color;
  final double height;
  const TurnBox({
    super.key,
    required this.visibility,
    required this.text,
    required this.color,
    required this.height,
  });
  @override
  Widget build(BuildContext context) {
    if (visibility) {
      return Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        height: (84 / 1257) * height,
        width: (507 / 1257) * height,
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.fredoka(
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
