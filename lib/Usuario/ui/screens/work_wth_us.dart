import 'package:do_my/Usuario/bloc/bloc_user.dart';
import 'package:do_my/Usuario/model/user.dart';
import 'package:do_my/widgets/logoSvg_widget.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class WorkWithUs extends StatefulWidget {
  User user;
  WorkWithUs({Key key, this.user});
  @override
  _WorkWithUsState createState() => _WorkWithUsState();
}

class _WorkWithUsState extends State<WorkWithUs> {
  bool checkConductor = false;
  UserBloc userBloc;
  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 90,
          child: Image.asset("images/logoPrimario.png"),
        ),
        SizedBox(height: 30.0,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CheckboxListTile(
              title: Text(
                "¿ Quieres trabajar con nosotros ?",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 12.0,


                ),
                textAlign: TextAlign.start,
              ),

              controlAffinity: ListTileControlAffinity.trailing,
              value: checkConductor,
              activeColor: Color.fromRGBO(58, 207, 227, 1.0),
              onChanged: (bool value){
                setState(() {
                  print("valor del chaeck -> $value");
                  checkConductor = value;
                });
              }
          ),
        ),
        SizedBox(height: 20.0,),

        RaisedButton(
          elevation: 0.0,
          color: Color.fromRGBO(9, 46, 135, 1.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          onPressed: (){

            if(checkConductor){
              widget.user.rol = "conductor";
            }else{
              widget.user.rol = "cliente";
            }

            widget.user.checkWork = true;

            userBloc.updateUser(user: widget.user);
          },
          child: Text("Continuar",
            style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.white

            ),
          ),
        )
      ],
    );;
  }
}
