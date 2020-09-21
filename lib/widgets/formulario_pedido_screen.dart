import 'package:do_my/Pedido/ui/screens/detalle_pedido_screen.dart';
import 'package:do_my/widgets/mapbox_full_screen.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

enum entrada {
  number,
  text,
  emailAddress
}

class FormularioPedido extends StatelessWidget {
  String tituloServicio;

  FormularioPedido(this.tituloServicio);
  @override
  Widget build(BuildContext context) {
    Widget fondo =  Container(

      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("images/mapaRuta.png",

            )
        ),
      ),
    );
    return Scaffold(
      body: Stack(
        children: [
          MapFullScreen(),
          DragShet(tituloServicio)

        ],
      ),
    );
  }
}

switchServicio(String titulo){

  switch(titulo){
    case "Taxi":
      return;
    case "Mensajería":
      return;
    case "Compras":
      return;
    case "Servicios públicos":
      return;
    case "Especial":

      return;
    default:
      return ;


  }

}

class DragShet extends StatelessWidget {
  String tituloServicio;
  DragShet(this.tituloServicio);
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.3,
      minChildSize: 0.2,
      maxChildSize: 0.6,
      builder: (context,scrollController){
        return Container(
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(
              color: Colors.black12,
              blurRadius: 20,
              offset: Offset(0.0,0.7)
            )]
          ),
          child: ListView(
            padding: EdgeInsets.all(16),
            controller: scrollController,
            children: [

              Column(
                children: [
                Container(
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color: Colors.grey,
                          width: 2
                      )
                  ),
                ),
                  RutaCompelta(tituloServicio),

                ],
              ),
            ],
          ),
        );



      },
    );
  }
}

class RutaCompelta extends StatelessWidget {

  String tituloServicio;

  RutaCompelta(this.tituloServicio);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(tituloServicio,
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold
          ),
        ),
        TimelineTile(

          alignment: TimelineAlign.start,
          isFirst: true,
          beforeLineStyle: LineStyle(
            thickness: 2,

              color: Color.fromRGBO(58, 207, 227, 1.0)
          ),
          indicatorStyle: IndicatorStyle(
            width: 30,
            color: Color.fromRGBO(9, 46, 135, 1.0),
            padding: const EdgeInsets.all(8),

            iconStyle: IconStyle(
              color: Colors.white,
              iconData: Icons.local_taxi

            ),
          ),

          startChild: InputRuta(textHint: "Origen",tipoEntrada: TextInputType.text,),
        ),
        TimelineTile(

          alignment: TimelineAlign.end,
          isLast: true,
          beforeLineStyle: LineStyle(
              thickness: 2,
              color: Color.fromRGBO(58, 207, 227, 1.0)
          ),
          indicatorStyle: IndicatorStyle(
            width: 30,
            color: Color.fromRGBO(9, 46, 135, 1.0),
            padding: const EdgeInsets.all(8),

            iconStyle: IconStyle(
                color: Colors.white,
                iconData: Icons.local_taxi

            ),
          ),
          startChild: InputRuta(textHint: "Destino",tipoEntrada: TextInputType.text,),
        ),

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            SizedBox(width: 8.0,),

            Icon(Icons.attach_money,size: 30, color: Color.fromRGBO(9, 46, 135, 1.0),),
            SizedBox(width: 8.0,),
            
            Expanded(child: InputRuta(textHint: "Precio",tipoEntrada: TextInputType.number,))

          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 8.0,),

            Icon(Icons.receipt,size: 30, color: Color.fromRGBO(9, 46, 135, 1.0),),
            SizedBox(width: 8.0,),

            Expanded(child: InputRuta(textHint: "Descripcion",line: 4,))

          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10,top: 10,left: 30,right: 30),

              child: Text(
                "Vehiculo de preferencia",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,

                    color: Color.fromRGBO(9, 46, 135, 1.0)
                ),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10,top: 10,left: 30,right: 30),

              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(58, 207, 227, 1.0),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Text(
                "Carro",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    color: Colors.white
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10,top: 10,right: 30),

              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(58, 207, 227, 1.0),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Text(
                "Moto",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    color: Colors.white
                ),
              ),
            )
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetallePedido()),
                );
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(9, 46, 135, 1.0),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Text(
                  "Confirmar",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    color: Colors.white
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

class InputRuta extends StatelessWidget {
  final String textHint;
  final TextInputType tipoEntrada;
  int line = 1;
  InputRuta({@required this.textHint,@required this.tipoEntrada,this.line});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),


      child: TextField(
        maxLines: line,
        keyboardType: tipoEntrada,

        style: TextStyle(
          fontSize: 14.0,
          fontFamily: "Poppins",
          color: Color(0xff707070),
          height: 1.0
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xffF6F6F6),
          labelText: textHint,
          labelStyle: TextStyle(
            color: Color.fromRGBO(9, 46, 135, 1.0)
          ),
          border: InputBorder.none,
          hintText: textHint,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffF6F6F6)),
            borderRadius: BorderRadius.circular(10),

          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffF6F6F6)),
            borderRadius: BorderRadius.circular(10),

          )
        ),
      ),
    );
  }
}



