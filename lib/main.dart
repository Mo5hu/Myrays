import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_rays/tabs/handy_talkie.dart';
import 'package:my_rays/tabs/leaderboard.dart';
import 'package:my_rays/tabs/map.dart';
import 'package:my_rays/tabs/settings.dart';
import 'package:my_rays/tabs/timeattack.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Map(),
    TimeAttack(),
    HandyTalkie(),
    Leaderboard(),
    Settings(),
    // Align(alignment: Alignment.topCenter,child: ,)
  ];

  void _onItemTapped(int index) {
    setState(() {
      // Provider.of<StateOfInteraction>(context, listen: false)
      //     .stateChanged(index);
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<Position>(
          initialData: Position(
            latitude: 0,
            longitude: 0,
            accuracy: 2,
            altitude: 4,
            timestamp: DateTime.now(),
            heading: 2,
            speed: 2,
            speedAccuracy: 4,
          ),
          create: (context) => Geolocator.getPositionStream(
              desiredAccuracy: LocationAccuracy.best),
        ),
        ChangeNotifierProvider(
          create: (_) => StateOfInteraction(stateCode: _selectedIndex),
        ),
      ],
      child: Consumer<StateOfInteraction>(
        builder: (context, value, child) {
          int? state = value._stateCode;
          print("---------------State: " + state.toString());
          return Scaffold(
            body: Stack(
              children: [
                Visibility(
                  visible: [1].contains(state),
                  child: AlertDialog(
                    title: Text("State: ($state)"),
                  ),
                ),
                Scaffold(
                  body: Center(
                    child: IndexedStack(
                      children: _widgetOptions,
                      index: _selectedIndex,
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.map_outlined),
                  label: 'Map',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.timer_sharp),
                  label: 'Time Attack',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.phone_in_talk_outlined),
                  label: 'Handy Talkie',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.leaderboard),
                  label: 'Leaderboard',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.grey[900],
              onTap: _onItemTapped,
            ),
          );
        },
      ),
    );
  }
}

class StateOfInteraction extends ChangeNotifier {
  int? _stateCode;

  StateOfInteraction({required stateCode}) : _stateCode = stateCode;

  stateChanged(int state) {
    _stateCode = state;
    notifyListeners();
  }
}
