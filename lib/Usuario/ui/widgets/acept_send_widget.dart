import 'package:flutter/material.dart';

class AceptSend extends StatefulWidget {
  VoidCallback callback;
  String text = "Continuar";
  AceptSend({Key key, this.callback, this.text});
  @override
  _AceptSend createState() => _AceptSend();
}

class _AceptSend extends State<AceptSend> {

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,

      child: InkWell(
        onTap: widget.callback,
        child: Ink(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(9, 46, 135, 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: Text(
            widget.text,
            style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
