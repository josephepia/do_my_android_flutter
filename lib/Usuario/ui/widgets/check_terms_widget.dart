import 'package:flutter/material.dart';

class CheckTerms extends StatefulWidget {
   bool check;

  CheckTerms({Key key, @required this.check});
  @override
  _CheckTermsState createState() => _CheckTermsState();
}

class _CheckTermsState extends State<CheckTerms> {

  @override
  Widget build(BuildContext context) {

    return CheckboxListTile(
        title: Text(
            "Acepto recibir mi código de confirmación",
          style: TextStyle(
            fontFamily: "Popins",
              fontSize: 12.0

          ),
        ),
        controlAffinity: ListTileControlAffinity.leading,
        value: widget.check,
        onChanged: (bool value){
          setState(() {
            print("valor del chaeck -> $value");
            widget.check = value;
          });
        }
    );
  }
}
