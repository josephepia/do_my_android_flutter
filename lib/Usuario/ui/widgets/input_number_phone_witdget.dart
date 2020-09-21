import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputNumberPhone extends StatefulWidget {
  int maxline = 1;
  final TextEditingController textController;
  final TextInputType tipeinpuText;
  final List<TextInputFormatter> listFormaterInpunt;
  final String text;
   String phoneNumber;
  InputNumberPhone({
    Key key,
    @required this.textController,
    @required this.tipeinpuText,
    @required this.listFormaterInpunt,
    @required this.text,
    @required this.phoneNumber,
    this.maxline,

    }
    );
  @override
  _InputNumberPhoneState createState() => _InputNumberPhoneState();


}

class _InputNumberPhoneState extends State<InputNumberPhone> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffF4F5F7),
        borderRadius: BorderRadius.all(Radius.circular(20.0))
      ),

      child: Row(

        children: [

         Container(
           margin: EdgeInsets.only(left: 20.0,right: 10.0),
           child: Text(
                  "+57",
                style: TextStyle(
                  fontFamily: "Popins",
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  color: Colors.black54,
                ),
              ),
         ),

          Flexible(

            child: TextFormField(
              controller: widget.textController,
              maxLines: 1,
              keyboardType: widget.tipeinpuText,
              inputFormatters: widget.listFormaterInpunt,
              onSaved: (value){
                widget.phoneNumber = value;
              },
              validator: (value) {
                if (value.isEmpty || value.length!= 10) {
                  return 'Por favor verifique el numero ingreasdo';
                }
                return null;
              },


//              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],

              style: TextStyle(

                  fontFamily: "Poppins",
//                color: Color(0xff707070),
              color: Colors.black54,
//                height: 1.0,
                fontWeight: FontWeight.bold,
                fontSize: 24.0
              ),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xffF6F6F6),
//                labelText: "numero telefonico",
                  labelStyle: TextStyle(
                      color: Color.fromRGBO(9, 46, 135, 1.0)
                  ),

                  border: InputBorder.none,
                  hintText: widget.text,
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

          )
        ],
      ),
    );
  }
}
