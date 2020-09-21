import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BotonInicioGoogle extends StatefulWidget {
   double width = 0.0;
   double height = 0.0;
   final VoidCallback onPressed;
   String text = "";

  BotonInicioGoogle({Key key,@required this.onPressed, this.width,  this.height, this.text});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BotonInicioGoogle();
  }

}

class _BotonInicioGoogle extends State<BotonInicioGoogle>{
  @override
  Widget build(BuildContext context) {

      return InkWell(
        onTap: widget.onPressed,

        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: EdgeInsets.only(
                top: 10.0,
                left: 20.0,
                right: 20.0
            ),
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),

            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   Container(
                     child: SvgPicture.asset(
                      "images/googleLogo.svg",
                      height: 24.0,
                     ),
                     margin: EdgeInsets.only(
                       left: 20,
                       right: 50
                     ),
                   ),

                   Expanded(
                     child: Text(widget.text,
                         style: TextStyle(
                           fontFamily: "Poppins",
                           color: Color.fromRGBO(9, 46, 135, 1.0),

                         )
                     ),
                   )


                 ],
            )
          ),
        ),
      );

  }

}
