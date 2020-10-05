import 'package:do_my/Usuario/bloc/bloc_user.dart';
import 'package:do_my/Usuario/model/user.dart';
import 'package:do_my/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:do_my/main.dart';
import 'package:do_my/servi/servi_navigator.dart';

class CompleteProfileOne extends StatefulWidget {
  User user;
  CompleteProfileOne({Key key, this.user});
  @override
  _CompleteProfileOneState createState() => _CompleteProfileOneState();
}

class _CompleteProfileOneState extends State<CompleteProfileOne> {
  UserBloc userBloc;

  TextEditingController inputNombre;
  TextEditingController inputTelefono;
  bool checkConductor = false;

  final formKeyDatosPrincipales = GlobalKey<FormState>();
  final  scaffoldKey = GlobalKey<ScaffoldState>();
  final navigatorKey = MyApp().navigatorKey;

  @override
  Widget build(BuildContext context) {

    inputNombre = TextEditingController();
    inputTelefono = TextEditingController();

    inputNombre.text = widget.user.nombre;
    inputTelefono.text = widget.user.telefono;

    userBloc = UserBloc();



    return Scaffold(
      key: scaffoldKey,
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 90,
                child: Image.asset("images/logo.png"),
              ),
              SizedBox(
                height: 50.0,
              ),
              Text(
                "Queremos conocerte",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
              Padding(
                padding:  EdgeInsets.all(16.0),
                child: Form(
                    key: formKeyDatosPrincipales,

                    child: Column(
                  children: [
                    Center(
                      child: CheckboxListTile(
                          title: Text(
                            "¿ Quieres trabajar con nosotros ?",
                            style: TextStyle(
                                fontFamily: "Popins",
                                fontSize: 12.0

                            ),
                          ),

                          controlAffinity: ListTileControlAffinity.leading,
                          value: checkConductor,
                          onChanged: (bool value){
                            setState(() {
                              print("valor del chaeck -> $value");
                              checkConductor = value;
                            });
                          }
                      ),
                    ),
                    TextFormField(
                      controller: inputNombre,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s"))
                      ],
                      onSaved: (value){
                        widget.user.nombre = value;
                      },
                      validator: (value) {
                        if (value.isEmpty || value == "") {
                          return 'Este campo es obligatorio';
                        }
                        return null;
                      },
                      style: TextStyle(
                        fontFamily: "Poppins"
                      ),

                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffF6F6F6),
//                labelText: "numero telefonico",
                          labelStyle:
                              TextStyle(color: Color.fromRGBO(9, 46, 135, 1.0)),
                          border: InputBorder.none,
                          hintText: "Nombre",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffF6F6F6)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffF6F6F6)),
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: inputTelefono,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                      onSaved: (value){
                        widget.user.telefono = value;
                      },
                      validator: (value) {
                        if (value.isEmpty || value.length!= 10) {
                          return 'Por favor verifique el numero ingreasdo';
                        }
                        return null;
                      },
                      style: TextStyle(
                          fontFamily: "Poppins"
                      ),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffF6F6F6),
//                labelText: "numero telefonico",
                          labelStyle:
                              TextStyle(color: Color.fromRGBO(9, 46, 135, 1.0)),
                          border: InputBorder.none,
                          hintText: "Telefono",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffF6F6F6)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffF6F6F6)),
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  ],
                )),
              ),
              SizedBox(
                height: 50.0,
              ),

              Builder(

                builder: (BuildContext contextwo){
                  return InkWell(
                    onTap: (){
                      if(formKeyDatosPrincipales.currentState.validate()){
                        formKeyDatosPrincipales.currentState.save();

                        print("datos del usuario");
                        print(widget.user.telefono);
                        print(widget.user.nombre);
                        if(checkConductor){
                          widget.user.rol = "conductor";
                        }


                        userBloc.updateUser(user: widget.user, checkConductor: checkConductor).then((value){
                          if(checkConductor){
                            locator<NavigationService>().navigateTo(routeName: 'completeProfileDriver', arguments: widget.user);
//                            navigatorKey.currentState.pushNamed('/completeProfileDriver', arguments: widget.user);
                          }
                        });
                      }
                    },
                    child: Ink(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(9, 46, 135, 1.0),
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Text(
                        "Continuar",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.white
                        ),
                      ),
                    ),
                  );
                },

              )

            ],
          ),
        ),
      ),
    );
  }
}
