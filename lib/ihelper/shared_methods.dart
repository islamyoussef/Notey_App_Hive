import 'dart:math';
import 'package:hive/hive.dart';
import 'package:my_notey/ihelper/hive_helper.dart';
import 'package:my_notey/ihelper/local_vars.dart';

import '../models/note.dart';

class SharedMethods{

  // Get random color index from the list of colors
  static int getRandomColor()
  {
    Random random = Random();
    int randomNumber = random.nextInt(lVarListOfColors.length);
    return randomNumber;
  }
}