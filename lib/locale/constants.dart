import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String ENGLISH = 'en';
const String HINDI = 'in';
const String LANGUAGE_CODE = 'languageCode';


Future<Locale> setLocaleinMemory(String languageCode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  print("setlocaleinmemory $languageCode");

  await prefs.setString(LANGUAGE_CODE, languageCode);

  return _locale(languageCode);

}







Locale _locale(String languageCode){
  Locale _temp;
  switch(languageCode){
    case ENGLISH:
      _temp = Locale(languageCode,'US');
      break;
    case HINDI:
      _temp = Locale(languageCode,'IN');
      break;
    default:
      _temp = Locale(languageCode,'US');
  }
  return _temp;
}

Future<Locale> getLocale() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String languageCode = prefs.getString(LANGUAGE_CODE) ??  ENGLISH;
  print("getlocale $languageCode");
  return _locale(languageCode);

}