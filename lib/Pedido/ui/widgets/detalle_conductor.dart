import 'package:flutter/material.dart';

class DetalleConductor extends StatefulWidget {
  @override
  _DetalleConductor createState() => _DetalleConductor();
}

class _DetalleConductor extends State<DetalleConductor> {
  @override
  Widget build(BuildContext context) {

    final cuerpo = Container(
      height: 128,
      width: double.infinity,
      padding: EdgeInsets.only(top: 32,left: 16,right: 16,bottom: 32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20.0,
            offset: Offset(0.0, 7.0),
            color: Colors.black12
          )
        ]
      ),
      child: Row(

        children: [
          Container(
            width: 50.0,
            height: 50.0,
            margin: EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('images/manPerfil.jpg'),
                fit: BoxFit.cover
              )
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text(
                "Nombre del conductor",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(9, 46, 135, 1.0)
                ),
              ),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow, size: 16,),
                  Icon(Icons.star, color: Colors.yellow, size: 16,),
                  Icon(Icons.star, color: Colors.yellow, size: 16,),
                  Icon(Icons.star, color: Colors.yellow, size: 16,),
                  Icon(Icons.star_half, color: Colors.yellow, size: 16,),
                ],
              ),
              Text(
                "Matricula: AAA123",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 12,
                    color: Color.fromRGBO(9, 46, 135, 1.0)
                ),
              ),
              Text(
                "Color vehiculo: Azul",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 12,
                    color: Color.fromRGBO(9, 46, 135, 1.0)
                ),
              ),
            ],
          )
        ],
      ),
    );

    final bottonLlamada = Container(
      width: double.maxFinite,
      margin: EdgeInsets.all(16),

    );



    return Container(
      child: Stack(
        children: [
          cuerpo,

        ],
      ),
    );
  }
}
