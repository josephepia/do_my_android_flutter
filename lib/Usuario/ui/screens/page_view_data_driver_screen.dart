import 'package:camera/camera.dart';
import 'package:do_my/Usuario/bloc/bloc_user.dart';
import 'package:do_my/Usuario/model/user.dart';
import 'package:do_my/Usuario/ui/screens/complete_data_vehicle_screen.dart';
import 'package:do_my/Usuario/ui/screens/complete_profile_data_driver_screen.dart';
import 'package:do_my/Usuario/ui/screens/complete_support_data_driver_screnn.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class PageViewDataDriver extends StatefulWidget {
  User user;
  PageViewDataDriver({Key key, this.user});
  final profileDataDriver = GlobalKey<FormState>();
  final vehicleDataDriver = GlobalKey<FormState>();
  final docummentDataDriver = GlobalKey<FormState>();
  @override
  _PageViewDataDriverState createState() => _PageViewDataDriverState();
}

class _PageViewDataDriverState extends State<PageViewDataDriver> {
  int currentPage = 0;
  PageController _pageController = PageController();
  UserBloc userBloc;

  CameraController cameraController;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(userBloc== null){
      if(cameraController == null){
        userBloc = BlocProvider.of<UserBloc>(context);
        cameraController = CameraController(userBloc.cameras[0], ResolutionPreset.high);
        cameraController.initialize().then((_) {
          if (!mounted) {
            return;
          }
          setState(() {});
        });
      }

    }
  }

  @override
  void initState() {
    super.initState();
    if(widget.user.minDataDriverComplete){
      currentPage = 1;
    }
    if(widget.user.minDataVehicleComplete){
      currentPage = 2;
    }


    _pageController = PageController(
      initialPage: currentPage
    );


    _pageController.addListener(() {
      if (_pageController.page.round() != currentPage) {
        setState(() {
          currentPage = _pageController.page.round();
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    return Scaffold(

        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20.0, width: 20.0,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                _pageIndicator(0),
                  _pageIndicator(1),
                  _pageIndicator(2),
                ],
              ),
              Expanded(
                child: PageView(

                  physics: NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  children: [
                    CompleteProfileDataDriver(user: widget.user, formKey: widget.profileDataDriver, cameraController: cameraController,),
                    CompleteDataVehicle(user: widget.user, formKey: widget.vehicleDataDriver, cameraController: cameraController,),
                    CompleteSupportDataDriver(user: widget.user, formKey: widget.docummentDataDriver, cameraController: cameraController,),

                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                
                children: [

                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  onPressed: _checkContinue(),
                  child: Text(
                    currentPage < 2 ? "Continuar": "Terminar"
                  ),
                )
              ],),
              SizedBox(
                height: 20.0,
                width: 20.0,
              )
            ],
          ),
        )
    );
  }

   _checkContinue(){
//    print("pagina -> ${_pageController.page.toInt() }");


      switch(currentPage){
        case 0:
          return ()async{
            if(widget.profileDataDriver.currentState.validate()){
              print("formulario compelto");

              widget.profileDataDriver.currentState.save();
              widget.user.minDataDriverComplete = true;
              await userBloc.updateUser(user: widget.user);
              setState(() {
                _pageController.nextPage(
                    duration: Duration(milliseconds: 400)
                    , curve: Curves.easeInOut);
              });
            }else{
              print("formulario incompelto");

              return (){

              };
            }


          };
          break;
        case 1:
          if(widget.user.minDataDriverComplete){

            return ()async{
              if(widget.vehicleDataDriver.currentState.validate()){
                print("formulario compelto");

                widget.vehicleDataDriver.currentState.save();
                widget.user.minDataVehicleComplete = true;
                await userBloc.updateUser(user: widget.user);
                Map<String, dynamic> update = Map<String, dynamic>();
                update['solicitudess/${widget.user.uid}/documentos/fotoVehiculo/url'] = widget.user.photoUrlCar;
                await userBloc.updateDatabaseMap('/', update);
                setState(() {
                  _pageController.nextPage(
                      duration: Duration(milliseconds: 400)
                      , curve: Curves.easeInOut);
                });
              }else{
                print("formulario incompelto");

                return (){

                };
              }


            };
          }else{
            return null;
          }
          break;
        case 2:
          if(widget.user.minDataVehicleComplete){

            return ()async{

                print("formulario compelto");


                widget.user.minDataDocumentComplete = true;
                widget.user.isNew = false;
                await userBloc.updateUser(user: widget.user);
                Map<String, dynamic> update = Map<String, dynamic>();
                update['solicitudess/${widget.user.uid}/documentos/identificacion/identificacionUrlA'] = widget.user.identificacionUrlA;
                update['solicitudess/${widget.user.uid}/documentos/identificacion/identificacionUrlB'] = widget.user.identificacionUrlB;

                update['solicitudess/${widget.user.uid}/documentos/licencia/licenciaConducirUrlA'] = widget.user.licenciaConducirUrlA;
                update['solicitudess/${widget.user.uid}/documentos/licencia/licenciaConducirUrlB'] = widget.user.licenciaConducirUrlB;

                update['solicitudess/${widget.user.uid}/documentos/soat/SOATUrlA'] = widget.user.SOATUrlA;

                await userBloc.updateDatabaseMap('/', update);
                setState(() {

                });



            };
          }else{
            return null;
          }
          break;
        default:
          return null;
          break;

      }

  }
  
  _pageIndicator(int page){
    return Container(
      height: 10.0,
      width: 10.0,
      margin: EdgeInsets.only(left: 10.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentPage == page  ? Colors.blue : Colors.grey
      ),
    );
  }
  
}
