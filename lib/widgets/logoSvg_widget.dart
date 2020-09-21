import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoSvgDomy extends StatelessWidget {
  double width = 0.0;
  double height;

  LogoSvgDomy({Key key, this.height,this.width});

  @override
  Widget build(BuildContext context) {
    if(this.width == null){
      width = MediaQuery.of(context).size.width;
//      height = MediaQuery.of(context).size.height;
    }
    return Container(
      margin: EdgeInsets.all(16),

      width: width,
      child: SvgPicture.asset("images/logo.svg")
      ,
    );
  }
}
