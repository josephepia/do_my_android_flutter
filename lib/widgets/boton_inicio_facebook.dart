import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BotonInicioFacebook extends StatefulWidget {
   double ancho = 0.0;
   double alto = 0.0;
   final VoidCallback onPressed;
   String text = "";

  BotonInicioFacebook({Key key,@required this.onPressed, this.ancho,  this.alto, this.text});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BotonInicioFacebookState();
  }

}

class BotonInicioFacebookState extends State<BotonInicioFacebook>{
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
            width: widget.ancho,
            height: widget.alto,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),

            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   Container(
                     child: Image.asset("images/facebookLogo.png",
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
