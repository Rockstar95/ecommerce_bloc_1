import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/MyPrint.dart';

class AppThemeProvider extends ChangeNotifier {
  int _themeMode = 1;

  AppThemeProvider() {
    initTheme();
  }

  int get themeMode => _themeMode;

  set themeMode(int value) {
    _themeMode = value;
    notifyListeners();
  }


  Future<int> initTheme() async {
    int themeMode = 1;

    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      int? data =  sharedPreferences.getInt("themeMode");
      if(data==null) {
        themeMode = 1;
      }
      else {
        themeMode = data;
      }
    }
    catch(e, s) {
      MyPrint.printOnConsole("Error in Getting Theme From SharedPreference:${e}");
      MyPrint.printOnConsole(s);
    }

    this.themeMode = themeMode;

    return themeMode;
  }

  Future<bool> updateTheme(int themeMode) async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setInt("themeMode", themeMode);
      return true;
    }
    catch(e, s) {
      MyPrint.printOnConsole("Error in Updatin Theme From SharedPreference:${e}");
      MyPrint.printOnConsole(s);
      return false;
    }
  }
}