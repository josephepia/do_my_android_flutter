import 'dart:async';

import 'package:do_my/Usuario/bloc/bloc_user.dart';
import 'package:do_my/Usuario/model/user.dart';
import 'package:do_my/Usuario/repository/auth_repository.dart';
import 'package:do_my/Usuario/ui/widgets/acept_send_widget.dart';
import 'package:do_my/widgets/logoSvg_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ValidatePhoneNumber extends StatefulWidget {
  @override
  _ValidatePhoneNumberState createState() => _ValidatePhoneNumberState();
}

class _ValidatePhoneNumberState extends State<ValidatePhoneNumber> {
  @override
  void initState() {
  }

  Future<void> _showMyDialog({Key key, @required String titulo, @required String cuerpo1, String cuerpo2}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          title: Text(titulo,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Poppins",
            color: Color.fromRGBO(9, 46, 135, 1.0)
          ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(cuerpo1 ?? '',style: TextStyle(
                    fontFamily: "Poppins",
                    color: Colors.blueGrey
                ),),
                Text(cuerpo2 ?? '', style: TextStyle(
                    fontFamily: "Poppins",
                    color: Colors.blueGrey

                ),),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Aceptar',style: TextStyle(
                  fontFamily: "Poppins",
                  color: Color.fromRGBO(9, 46, 135, 1.0)
              ),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    UserBloc blocUser = BlocProvider.of<UserBloc>(context);
    print("argumentos que llegan ${ModalRoute.of(context).settings.arguments}");
    String numberPhone = ModalRoute.of(context).settings.arguments;
    StreamController<ErrorAnimationType> errorController = StreamController<ErrorAnimationType>();

    String codeText;

    TextEditingController inputCode = TextEditingController();
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/logoPrimario.png"),
                            fit: BoxFit.contain)),
                    height: 70.0,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    child: Text(
                      "Verificación de numero telefonico",
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Color.fromRGBO(9, 46, 135, 1.0),
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins"),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Container(
                    child: Text(
                      "Ingrese el código de verificación enviado al numero +57${numberPhone ?? ''}",
                      style: TextStyle(
                          color: Color(0xfff707070),
                          fontWeight: FontWeight.normal,
                          fontFamily: "Poppins",
                          fontSize: 12.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 30.0,right: 30.0),
                    child: PinCodeTextField(
                      length: 6,
                      obsecureText: false,
                      animationType: AnimationType.fade,

                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.underline,
                        borderRadius: BorderRadius.circular(10.0),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                        activeColor: Color.fromRGBO(9, 46, 135, 1.0),
                        inactiveFillColor: Colors.transparent,
                        selectedColor: Colors.black12,
                        selectedFillColor: Colors.black12,

                      ),
                      animationDuration: Duration(milliseconds: 300),
                      backgroundColor: Colors.transparent,
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: inputCode,
                      onCompleted: (v) {

                        blocUser.signIn(providerAuth: ProviderAuth.phone,codeSms: v).then((authResult){
                          print('verificado correctamente');
                          var user =  User(
                              uid: authResult.user.uid,
                              nombre: authResult.user.displayName,
                              correo: authResult.user.email,
                              photoUrl: authResult.user.photoUrl,
                              telefono: authResult.user.phoneNumber

                            //                          dateCreate: ServerValue.timestamp
                          );
                          if(authResult.additionalUserInfo.isNewUser){

                            blocUser.saveUser(user);
                          }else{
                            user.isNew = false;

                            blocUser.lastLoginUser(user);

                          }

                          var count = 0;
                          Navigator.popUntil(context, (route) {
                            return count++ == 2;
                          });
//                          Navigator.popUntil(context, ModalRoute.withName('login'));
                        }).catchError((error){
                          print("error a lverificar el codigo ");
                          print(error);

                          _showMyDialog(titulo: "Advertencia", cuerpo1: "El codigo ingresado no es valido", cuerpo2: "por favor verifique e intentelo de nuevo");

                        });


                      },
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      textInputType: TextInputType.number,
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          codeText = value;
                        });
                      },
                      validator: (value){
                        if(value.length > 6 || value.isEmpty){
                          return "verifique el codigo ingresado";
                        }
                        return null;
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),

                  Container(
                      child: RichText(
                    text: TextSpan(
                      text: '¿no recibiste el código de confirmación ? ',
                      style: TextStyle(
                          color: Color(0xfff707070),
                          fontWeight: FontWeight.normal,
                          fontFamily: "Poppins",
                          fontSize: 12.0),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Reenviar',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0,
                                color: Color.fromRGBO(9, 46, 135, 1.0),

                                ),

                            recognizer: TapGestureRecognizer()..onTap = (){
                              blocUser.sendVerificarionPhone("+57$numberPhone").then((value){
                                print("codigo de verificacion enviado value->$value");
//                                _showMyDialog(titulo: "Verificación", cuerpo1: "El codigo ha sido enviado nuevamente", cuerpo2: "al numero $numberPhone");

                              }).catchError((error){
                                  print("error al intentar enviar e lcodigo de verificacion $error");
//                                  _showMyDialog(titulo: "Advertencia", cuerpo1: "Ha ocurrido un error", cuerpo2: "lo sentimos, no fue posible reeenviar el codigo de verificación a $numberPhone");

                              });
                            }),
                      ],
                    ),
                  )
//
                      ),
        

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
