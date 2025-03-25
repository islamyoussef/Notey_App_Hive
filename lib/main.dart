import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_notey/ihelper/local_vars.dart';
import 'package:my_notey/views/frm_notey_home.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(lVarNotesBox);

  runApp(const NoteyApp());
}

class NoteyApp extends StatelessWidget {
  const NoteyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notey',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        fontFamily: 'Poppins',
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark ,
      home: const FrmNoteyHome(),
    );
  }
}
