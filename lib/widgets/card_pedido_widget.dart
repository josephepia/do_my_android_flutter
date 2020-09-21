import 'package:do_my/Usuario/ui/screens/detail_service_standby_screen.dart';
import 'package:flutter/material.dart';

class CardPedido extends StatelessWidget {

  String imagen;
  String titulo;
  String descripcion;


  CardPedido({this.imagen,this.titulo,this.descripcion});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.0,
      margin: EdgeInsets.only(bottom: 13.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                blurRadius: 20.0,
                color: Colors.black38,
                offset: Offset(0.0, 0.7)

            )
          ]
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailServiceStandby()),
            );
          },
          child: Container(

            child: Row(

              children: [
                Container(
                  width: 50.0,
                  height: 50.0,

                  margin: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(this.imagen),
                          fit: BoxFit.cover
                      )
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        this.titulo,
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins"
                        ),
                      ),
                      Text(
                        this.descripcion,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal,
                          fontFamily: "Poppins",

                        ),

                      ),



                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}