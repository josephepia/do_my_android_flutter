import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:do_my/Pedido/ui/screens/detalle_pedido_screen.dart';
import 'package:do_my/Usuario/ui/screens/login.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

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
   List<Widget> widgetsChildren = [
    Login(),
    Login(),
    Login(),
    DetallePedido(),
    Login(),
  ];


  @override
  void initState() {
    selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: widgetsChildren[selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(
            color: Colors.black12,
            blurRadius: 20.0,
              offset: Offset(0.0,0.7)
          )],
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(58, 207, 227, 1.0),
              Colors.white
            ]
          )
        ),
        child: ConvexAppBar(

          items: [
            TabItem(icon: Icons.home, title: 'Home',),
            TabItem(icon: Icons.receipt, title: 'Pedidos'),
            TabItem(icon: Icons.timelapse, title: 'Historial'),
            TabItem(icon: Icons.person, title: 'Profile'),
          ],
          initialActiveIndex: 2,//optional, default as 0
          onTap: (int i) => print('click index=$i'),
          height: 60.0,
          backgroundColor: Colors.white,
          color: Color(0xFFacb5c5),
          top: -15.0,
          activeColor: Color.fromRGBO(58, 207, 227, 1.0),
        ),
      )
    );
  }
}

