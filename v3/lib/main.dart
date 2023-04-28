import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_1800/firebase_options.dart';
import 'package:flutter_1800/pages/home.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/route_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white, 
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Color primaryColor = Colors.tealAccent;

  @override
  void initState() {
    //setMode();
  }

  @override
  Widget build(BuildContext context) {
    final easyload = EasyLoading.init();

    return GetMaterialApp(
      title: 'Film market',
      builder: (BuildContext context, Widget? child) {
        return easyload(context, child);
      },
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: const Color(0x0fffffff),
          textTheme: const TextTheme(labelLarge: TextStyle(color: Colors.blue)),
          appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: Colors.black),
              titleTextStyle: TextStyle(
                  color: Color.fromARGB(255, 65, 57, 57), fontSize: 20.0),
              color: Colors.white)),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
