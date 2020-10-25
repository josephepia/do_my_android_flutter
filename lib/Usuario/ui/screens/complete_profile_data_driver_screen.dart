import 'package:camera/camera.dart';
import 'package:do_my/Usuario/model/user.dart';
import 'package:do_my/Usuario/ui/screens/camera_preview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CompleteProfileDataDriver extends StatefulWidget {
  User user;
  GlobalKey formKey = GlobalKey<FormState>();
  
  CameraController cameraController ;

  CompleteProfileDataDriver({Key key, this.user, this.formKey, this.cameraController });
  @override
  _CompleteProfileDataDriverState createState() =>
      _CompleteProfileDataDriverState();
}

class _CompleteProfileDataDriverState extends State<CompleteProfileDataDriver> {
  TextEditingController inputIdentificacion = TextEditingController();
  TextEditingController inputNombre = TextEditingController();
  TextEditingController inputTelefono= TextEditingController();
  TextEditingController inputTipoSangre= TextEditingController();



//  final piker = ImagePicker();
  Color colorPrimary = Color.fromRGBO(9, 46, 135, 1.0);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: widget.formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      Container(
                        width: 100.0,
                        height: 100.0,
                        margin: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(widget.user.photoUrl),
                                fit: BoxFit.cover)),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            FloatingActionButton(
                                mini: true,
                                child: Icon(
                                  Icons.photo_camera,
                                  color: Colors.white,
                                ),
                                backgroundColor: Color.fromRGBO(9, 46, 135, 1.0),
                                onPressed: (){
                                print("clic en cambiar  foto ");
                                final pathDestinationStorage = "imagenes/${widget.user.uid}/perfil/perfil.jpg";
                                final refDestinationDatabase = "usuarios/${widget.user.uid}/photoUrl";
                                Navigator.push(context,
                                MaterialPageRoute(builder: (context)=> CameraPreviewDomy(cameraController: widget.cameraController,user: widget.user, pathDestinationStorage: pathDestinationStorage, refDestinationDatabase: refDestinationDatabase,))
                                );

                            }),

                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(

                        controller: inputIdentificacion,
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        onSaved: (value) {
                          widget.user.identificacion = value;
                        },
                        validator: (value) {
                          if (value.isEmpty || value == "") {
                            return 'Este campo es obligatorio';
                          }
                          return null;
                        },
                        style: TextStyle(fontFamily: "Poppins"),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffF6F6F6),
//                labelText: "numero telefonico",
                            labelStyle: TextStyle(
                                color: Color.fromRGBO(9, 46, 135, 1.0)),
                            border: InputBorder.none,
                            hintText: "Identificación",
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Color(0xffF6F6F6)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Color(0xffF6F6F6)),
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                      SizedBox(height: 10.0,),
                      TextFormField(
                        controller: inputNombre,

                        textCapitalization: TextCapitalization.words,
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s"))
                          ],
                        onSaved: (value) {
                          widget.user.nombre = value;
                        },
                        validator: (value) {
                          if (value.isEmpty || value == "") {
                            return 'Este campo es obligatorio';
                          }
                          return null;
                        },
                        style: TextStyle(fontFamily: "Poppins",

                        ),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffF6F6F6),
//                labelText: "numero telefonico",
                            labelStyle: TextStyle(
                                color: Color.fromRGBO(9, 46, 135, 1.0)),
                            border: InputBorder.none,
                            hintText: "Nombre",

                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Color(0xffF6F6F6)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Color(0xffF6F6F6)),
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                      SizedBox(height: 10.0,),
                      TextFormField(
                        controller: inputTelefono,
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        onSaved: (value) {
                          widget.user.telefono = value;
                        },
                        validator: (value) {
                          if (value.isEmpty || value == "") {
                            return 'Este campo es obligatorio';
                          }
                          return null;
                        },
                        style: TextStyle(fontFamily: "Poppins"),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffF6F6F6),
//                labelText: "numero telefonico",
                            labelStyle: TextStyle(
                                color: Color.fromRGBO(9, 46, 135, 1.0)),
                            border: InputBorder.none,
                            hintText: "No. Movil",
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Color(0xffF6F6F6)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Color(0xffF6F6F6)),
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                      SizedBox(height: 10.0,),
                      DropdownButtonFormField(
                        value: widget.user.tipoSangre,

                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffF6F6F6),
//                labelText: "numero telefonico",
                            labelStyle: TextStyle(
                                color: Color.fromRGBO(9, 46, 135, 1.0)),
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Color(0xffF6F6F6)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Color(0xffF6F6F6)),
                              borderRadius: BorderRadius.circular(10),
                            )),

                          items: [
                            DropdownMenuItem(value: null, child: Text("Seleccione", style: TextStyle(fontFamily: "Poppins", ),)),
                            DropdownMenuItem(value: "A+", child: Text("A+", style: TextStyle(fontFamily: "Poppins", ),)),
                            DropdownMenuItem(value: "A-", child: Text("A-", style: TextStyle(fontFamily: "Poppins", ),)),
                            DropdownMenuItem(value: "B+", child: Text("B+", style: TextStyle(fontFamily: "Poppins", ),)),
                            DropdownMenuItem(value: "B-", child: Text("B-", style: TextStyle(fontFamily: "Poppins", ),)),
                            DropdownMenuItem(value: "AB+", child: Text("AB+", style: TextStyle(fontFamily: "Poppins", ),)),
                            DropdownMenuItem(value: "AB-", child: Text("AB-", style: TextStyle(fontFamily: "Poppins", ),)),
                            DropdownMenuItem(value: "O+", child: Text("O+", style: TextStyle(fontFamily: "Poppins", ),)),
                            DropdownMenuItem(value: "O-", child: Text("O-", style: TextStyle(fontFamily: "Poppins", ),)),
                          ],
                        onChanged: (String newValue) {
                          setState(() {
//                          dropdownValue = newValue;
                            FocusScope.of(context).requestFocus(new FocusNode());
                          widget.user.tipoSangre = newValue;
                          });
                        },
                        onSaved: (value) {
                          widget.user.tipoSangre = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty || value == "" ) {
                            return 'Seleccione una opcion';
                          }
                          return null;
                        },
                      ),
//                    SizedBox(height: 10.0,),
//                    RaisedButton(
//                      color: colorPrimary,
//                      shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(10.0)
//                      ),
//                        elevation: 0.0,
//                        onPressed: (){
//
//                        },
//                      child: Text(
//                        "Continuar",
//
//                      ),
//                    )



                    ],
                  )
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    this.inputNombre.text = widget.user.nombre;
    this.inputIdentificacion.text = widget.user.identificacion;
    this.inputTelefono.text = widget.user.telefono;
//    this.inputTipoSangre.text = widget.user.tipoSangre;
  }
}
