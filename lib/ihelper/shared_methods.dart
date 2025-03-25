import 'dart:math';
import 'package:my_notey/ihelper/local_vars.dart';

class SharedMethods{

  static int getRandomColor()
  {
    Random random = Random();
    int randomNumber = random.nextInt(lVarListOfColors.length);
    return randomNumber;
  }

}