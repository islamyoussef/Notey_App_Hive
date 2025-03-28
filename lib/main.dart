import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_notey/cubits/note_cubit.dart';
import 'package:my_notey/ihelper/hive_helper.dart';
import 'package:my_notey/ihelper/local_vars.dart';
import 'package:my_notey/views/frm_notey_home.dart';

import 'models/note.dart';

void main() async {

  // Hive preparation
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());  /* Modal name + Adapter */
  await HiveHelper.init();              /* Open hive box */

  runApp(const NoteyApp());
}

class NoteyApp extends StatelessWidget {
  const NoteyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => NoteCubit()..getAllNotes(),

    child: MaterialApp(
      title: 'Notey',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        fontFamily: 'Poppins',
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark ,
      home: const FrmNoteyHome(),
    ));
  }
}
