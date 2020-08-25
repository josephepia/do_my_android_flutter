import 'package:flutter/material.dart';

class Gradiente extends StatelessWidget {

  double alto = 0.0;
  final Color colorPrimario;
  final Color colorSecundario;
  Gradiente({Key key,@required this.colorPrimario,@required this.colorSecundario, this.alto});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorPrimario,
            colorSecundario,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        )
      ),
    );
  }
}
