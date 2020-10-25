import 'package:flutter/material.dart';

class VisualizarImagen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('visualiar foto'),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
//              image: Image.file(File)
            )
          ),
        )
    );
  }
}
