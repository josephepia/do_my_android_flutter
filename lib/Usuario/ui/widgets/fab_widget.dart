import 'package:flutter/material.dart';

class FAB extends StatelessWidget {
  final VoidCallback onPress;
  final String size;
  final IconData icon;
  final Color backColor;
  final String text;
  final Color textColor;
  final bool isMini;


  FAB({Key key,this.onPress, this.size, this.icon, this.backColor, this.text,this.textColor,this.isMini});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: [
          FloatingActionButton(
            heroTag: null,
              onPressed: this.onPress,
            child: Icon(this.icon),
            backgroundColor: this.backColor,
            mini: this.isMini,
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Text(
              this.text,
              style: TextStyle(
                fontFamily: "Poppins",
                color: this.textColor,

              ),
            ),
          )
        ],
      ),
    );
  }
}
