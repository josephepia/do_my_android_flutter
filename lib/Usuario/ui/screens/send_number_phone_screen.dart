import 'package:do_my/Usuario/bloc/bloc_user.dart';
import 'package:do_my/Usuario/ui/widgets/acept_send_widget.dart';
import 'package:do_my/Usuario/ui/widgets/check_terms_widget.dart';
import 'package:do_my/Usuario/ui/widgets/input_number_phone_witdget.dart';
import 'package:do_my/widgets/logoSvg_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class SendNumberPhone extends StatefulWidget {
  @override
  _SendNumberPhoneState createState() => _SendNumberPhoneState();
}

class _SendNumberPhoneState extends State<SendNumberPhone> {
  UserBloc blocUser;
  String phoneNumber;
  bool checkTerms = false;

  final formKey = GlobalKey<FormState>();
  TextEditingController inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    blocUser = BlocProvider.of<UserBloc>(context);
    return Scaffold(

      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: ListView(
                shrinkWrap: true,
              children: [

                Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,

                  children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/logo.png"),
                        fit: BoxFit.contain
                      )
                    ),
                    height: 70.0,

                  ),
                    SizedBox(height: 20.0,),
                    Container(
                      child: Text(
                        "Regístrate con numero de celular",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Color.fromRGBO(9, 46, 135, 1.0),
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins"
                        ),
                        textAlign: TextAlign.center,

                      ),
                    ),
                    SizedBox(height: 25.0,),
                    Container(
                      child: Text(
                        "Enviaremos un mensaje de texto con un código de confirmación a este número",
                        style: TextStyle(
                            color: Color.fromRGBO(9, 46, 135, 1.0),
                            fontWeight: FontWeight.normal,
                            fontFamily: "Poppins",
                            fontSize: 12.0
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),

                    InputNumberPhone(
                      listFormaterInpunt: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      text: "3000000000",
                      textController: inputController,
                      tipeinpuText: TextInputType.number,
                      maxline: 1,
                    ),
                    SizedBox(
                      height: 50.0,
                    ),


                    Center(
                      child: CheckboxListTile(
                          title: Text(
                            "Acepto recibir mi código de confirmación",
                            style: TextStyle(
                                fontFamily: "Popins",
                                fontSize: 12.0

                            ),
                          ),

                          controlAffinity: ListTileControlAffinity.leading,
                          value: checkTerms,
                          onChanged: (bool value){
                            setState(() {
                              print("valor del chaeck -> $value");
                              checkTerms= value;
                            });
                          }
                      ),
                    ),
                    SizedBox(height: 20.0,),

                    Builder(
                      builder: (BuildContext context){
                        return AceptSend(text: "Continuar", callback: (){

//                blocUser.sendVerificarionPhone()
//                  Navigator.of(context).pushNamed('/phoneLogin');
                          if(formKey.currentState.validate()){
                            formKey.currentState.save();
                            //                  Navigator.of(context).pushNamed('/phoneLogin');
                            print("datos del formulario phoneNumber${inputController.text} \n check ${checkTerms}");

                            if(checkTerms){
//                              Navigator.of(context).pushNamed('/codePhoneValidate', arguments: inputController.text);
                              blocUser.sendVerificarionPhone('+57${inputController.text}').then((value) => Navigator.of(context).pushNamed('/codePhoneValidate', arguments: inputController.text));
                            }else{
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content:  Text("Debe aceptar los terminos"))
                              );
                            }
                          }
                        },);
    }
                    ),
                    SizedBox(height: 50.0,),

                    Container(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'Al realizar el registro acepta los términos y condiciones y políticas de privacidad (Habeas Data) ',

                            style: TextStyle(
                                color: Color(0xfff707070),
                                fontWeight: FontWeight.normal,
                                fontFamily: "Poppins",
                                fontSize: 10.0,


                            ),

                            children: <TextSpan>[

                              TextSpan(
                                  text: 'Términos y condiciones',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12.0,
                                    color: Color.fromRGBO(58, 207, 227, 1.0),

                                  ),

                                  recognizer: TapGestureRecognizer()..onTap = (){
                                    print("terminos y condiciones");
                                  }),
                            ],
                          ),
                        )
//
                    ),

                  ],
              ),
                ),]
            ),
          ),
        ),
      ),
    );
  }
}
