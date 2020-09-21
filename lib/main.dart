import 'package:do_my/Pedido/bloc/bloc_pedido.dart';
import 'package:do_my/Usuario/bloc/bloc_user.dart';
import 'package:do_my/Usuario/ui/screens/complete_profile_driver_screen.dart';
import 'package:do_my/Usuario/ui/screens/send_number_phone_screen.dart';
import 'package:do_my/Usuario/ui/screens/validate_phone_number_screen.dart';
import 'package:do_my/service_locator.dart';
import 'package:do_my/widgets/gradiente.dart';
import 'package:do_my/widgets/mapbox_full_screen.dart';
import 'package:do_my/widgets/navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:geocoder/geocoder.dart';
import 'package:do_my/Usuario/ui/screens/login.dart';
import 'package:do_my/servi/servi_navigator.dart';

void main() {
//  WidgetsFlutterBinding.ensureInitialized();
//  await Firebase.initializeApp();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  // From a query
  final GlobalKey<NavigatorState> navigatorKey =  GlobalKey<NavigatorState>();
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
    ));
    return BlocProvider(
      child: BlocProvider(
        child: MaterialApp (
          navigatorKey: locator<NavigationService>().navigatorKey,
            title: 'Do-my',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
//            home: Login()

            routes: {
              '/': (BuildContext context)=> Login(),
              '/phoneLogin': (BuildContext context)=> SendNumberPhone(),
              '/codePhoneValidate': (BuildContext context)=> ValidatePhoneNumber(),
              '/completeProfileDriver': (BuildContext context)=> CompleteProfileDriver()
        },
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
        ),
        bloc: PedidoBloc(),
      ),
      bloc: UserBloc(),

    ) ;

  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;


  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      _cargarMapa();
    });
  }

  _cargarMapa() async{
    final query = "calle 16 # 20 -54 valledupar";
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    print("${first.featureName} : ${first.coordinates}");

// From coordinates
    final coordinates = new Coordinates(10.4663699, -73.2653046);
    addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    first = addresses.first;
    print("${first.featureName} : ${first.addressLine}");
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


