import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:do_my/Pedido/ui/screens/detalle_pedido_screen.dart';
import 'package:do_my/Usuario/bloc/bloc_user.dart';
import 'package:do_my/Usuario/ui/screens/login.dart';
import 'package:do_my/widgets/historial_screen.dart';
import 'package:do_my/widgets/home_screen.dart';
import 'package:do_my/widgets/pedidos_screen.dart';
import 'package:do_my/widgets/profile_menu.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class NavigationBar extends StatefulWidget {
  String title = "";
  @override
  _NavigationBar createState() => _NavigationBar();
}

class _NavigationBar extends State<NavigationBar> {
  int _page = 0;
  double _padding = 6;
  int selectedIndex = 0 ;
  List<double> _paddings =[
    6.0,6.0,6.0,6.0
  ];
   List<Widget> widgetsChildren;


  @override
  void initState() {
  }

  @override
  Widget build(BuildContext context) {
    widgetsChildren =  [
      Home(),
      Pedidos(),
      Historial(),
      ProfileMenu(),
//    BlocProvider(
//      bloc: BlocProvider.of(context),
//      child: Home(),
//    ),
//
//     BlocProvider(
//      bloc: BlocProvider.of(context),
//      child: Pedidos(),
//    ),
//     BlocProvider(
//       bloc: BlocProvider.of(context),
//       child: Historial(),
//     ),
//     BlocProvider(
//       bloc: BlocProvider.of(context),
//       child: ProfileMenu(),
//     ),





    ];
    return Scaffold(


      body: widgetsChildren[selectedIndex],
      bottomNavigationBar: ConvexAppBar(

        items: [
          TabItem(icon: Icons.home, title: 'Inicio',),
          TabItem(icon: Icons.receipt, title: 'Pedidos'),
          TabItem(icon: Icons.timelapse, title: 'Historial'),
//            TabItem(icon: Icons.person, title: 'Perfil'),
          TabItem(icon: Icons.settings, title: 'Menú'),
        ],
        initialActiveIndex: 0,//optional, default as 0
        onTap: (int i){
          setState(() {
            print('index ${i}');
            selectedIndex = i;
          });
        },
        height: 60.0,
        backgroundColor: Colors.white,
        color: Color(0xFFacb5c5),
        top: -15.0,
        activeColor: Color.fromRGBO(58, 207, 227, 1.0),
      )
    );
  }
}

