import 'package:flutter/material.dart';

class RequestDriverDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Detallles de la solicitud', style: TextStyle(
            fontFamily: "Poppins",

          ),),
        ),
        body: Center(
          child: Text('Detallles de la solicitud', style: TextStyle(
            fontFamily: "Poppins",

          )

        )
        )
            );
  }
}
