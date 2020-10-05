import 'package:do_my/Usuario/model/user.dart';
import 'package:flutter/material.dart';

class CardProfile extends StatelessWidget {
  double height;
  double width;
  String imageUrl;
  User usuario;


  CardProfile({Key key,this.height, this.width, this.imageUrl,this.usuario});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment(0.0, -2.0),
//        fit: StackFit.loose,
      overflow: Overflow.visible,

      children: [

        Container(
          width: 310,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20.0,
                offset: Offset(0.0,0.7)
              )
            ]

          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              SizedBox(
                height: 65.0,
              ),

              Text(
                usuario.nombre,
                style: TextStyle(
                  fontFamily: "Poppins",
                  color: Color.fromRGBO(28, 28, 28, 1),
                  fontWeight: FontWeight.bold,

                ),
              ),

              Row(
                  children: [
                    Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              usuario.identificacion ?? '',
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold

                              )
                          ),
                          Text(
                              "Identificacion",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.0,
                                  color: Colors.grey

                              )
                          ),

                        ]
                    )

                  ]
              ),
              Row(
                  children: [
                    Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              usuario.telefono ?? '',
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold

                              )
                          ),
                          Text(
                              "Telefono",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.0,
                                  color: Colors.grey

                              )
                          ),

                        ]
                    )

                  ]
              ),
              Row(
                  children: [
                    Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              usuario.tipoSangre ?? '',
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold

                              )
                          ),
                          Text(
                              "Tipo de sangre",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.0,
                                  color: Colors.grey

                              )
                          ),

                        ]
                    )

                  ]
              ),

            ],
          )
        ),
        Positioned(
          top: -55,

          child: Container(
            height: 110.0,
            width: 110.0,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(imageUrl ?? ''),
                  fit: BoxFit.cover,


                ),
                border: Border.all(
                    color: Colors.white,
                    style: BorderStyle.solid,
                    width: 3
                ),

                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20.0,
                      offset: Offset(0.0,0.7)
                  )
                ]

            ),
          ),
        ),
      ],
    );
  }
}
