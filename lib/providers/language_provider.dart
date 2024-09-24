import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class languageProvider with ChangeNotifier {

  String? language ;

  store(String lan) async {
    language = lan ;
    SharedPreferences prefs = await  SharedPreferences.getInstance();
    prefs.setString("language",language??"en");
    get(); 
  }
  get() async {
    SharedPreferences prefs = await  SharedPreferences.getInstance();
    if (prefs.getString("language")!=null){
      language = prefs.getString("language");
    }else{
      language = "en";
    }
    notifyListeners();
  }
}