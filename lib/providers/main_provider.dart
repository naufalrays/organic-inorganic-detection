import 'package:flutter/cupertino.dart';
import 'package:organic_inorganic_detection/screens/home_screen.dart';

import '../screens/about_screen.dart';

class MainProvider extends ChangeNotifier {
  int _index = 0;
  int get index => _index;

  List<Widget> screens = [
    const HomeScreen(),
    const AboutScreen(),
  ];

  void selectDestionation(int value) {
    _index = value;
    notifyListeners();
  }
}
