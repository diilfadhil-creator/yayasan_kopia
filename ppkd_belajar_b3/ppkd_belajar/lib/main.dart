// import 'package:flutter/material.dart';
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:ppkd_belajar/Day_14/tugas7saya.dart';
// import 'package:ppkd_belajar/Day_15/menu_navbar/navbar.dart';
// import 'package:ppkd_belajar/Day_15/tugas9.dart';
// import 'package:ppkd_belajar/apk_baziz/login.dart';
// import 'package:ppkd_belajar/day_10/showimages.dart';
// import 'package:ppkd_belajar/day_10/stf.dart';
// import 'package:ppkd_belajar/day_11/home.dart';
// import 'package:ppkd_belajar/day_11/routing.dart';
// import 'package:ppkd_belajar/day_11/tugas11.dart';
// import 'package:ppkd_belajar/day_13/bottomnav.dart';
// import 'package:ppkd_belajar/day_13/drawer.dart';
// import 'package:ppkd_belajar/day_13/input_widget/checkbox.dart';
// import 'package:ppkd_belajar/day_17/service/prefrence_handler.dart';
// import 'package:ppkd_belajar/day_17/views/login_day_17.dart';
// import 'package:ppkd_belajar/day_17/views/splash_screen.dart';
// import 'package:ppkd_belajar/day_18/views/login_day_18.dart';
// import 'package:ppkd_belajar/day_5/layouting.dart';
// import 'package:ppkd_belajar/day_5/scaffold.dart';
// import 'package:ppkd_belajar/day_5/styling.dart';
// import 'package:ppkd_belajar/day_6/center.dart';
// import 'package:ppkd_belajar/day_6/container.dart';
// import 'package:ppkd_belajar/day_6/expanded.dart';
// import 'package:ppkd_belajar/day_6/image.dart';
// import 'package:ppkd_belajar/day_6/layouting.dart';
// import 'package:ppkd_belajar/day_6/layouting.dart';
// import 'package:ppkd_belajar/day_7/tugas2.dart';
// import 'package:ppkd_belajar/day_8/stack.dart';
// import 'package:ppkd_belajar/day_8/tugas3.dart';
// import 'package:ppkd_belajar/day_8/tugas4.dart';
// import 'package:ppkd_belajar/day_9/day9.dart';
// import 'package:ppkd_belajar/day_9/tugas9.dart';
// import 'package:ppkd_belajar/tugas_1/tugas1.dart';
// import 'package:ppkd_belajar/tugas_10/register_page.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await initializeDateFormatting('id_ID', null);
//   await PreferenceHandler.init();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a purple toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: .fromSeed(seedColor: Colors.deepPurple),
//       ),
//       //push name
//       initialRoute: '/',
//       routes: {
//         //'/': (context) => SplashScreenDay17(),
//         // '/home': (context) => Homeday11(),
//       },
//       home:
//           LoginDay18SQFLITE(), // TODO: Complete implementationDay5// TODO: Complete implementation// TODO: Complete implementationldDay5(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: .center,
//           children: [
//             const Text('You have pushed the button this many times:'),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
