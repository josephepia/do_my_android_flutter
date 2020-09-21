
import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
  new GlobalKey<NavigatorState>();
  Future<dynamic> navigateTo({Key key,@required String routeName, Object arguments}) {
    //                            navigatorKey.currentState.pushNamed('/completeProfileDriver', arguments: widget.user);

    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }
}