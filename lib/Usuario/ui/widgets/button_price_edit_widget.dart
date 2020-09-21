import 'package:flutter/material.dart';

class ButtonPrice extends StatelessWidget {
  final String text;
  final Color backColor;
  final Color textColor;
  final VoidCallback onPress;


  ButtonPrice({Key key,this.text, this.backColor,this.textColor, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: this.backColor,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Text(
        this.text,
        style: TextStyle(
          fontFamily: "Poppins",
          color: this.textColor
        ),
      ),
    );
  }
}
