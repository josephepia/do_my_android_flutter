import 'package:flutter/material.dart';

class PageError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Lo sentimos algo salió mal \n revisa tu conexión a internet",
        style: TextStyle(
          fontFamily: "Poppins",
          color: Colors.grey
        ),
      ),
    );
  }
}
