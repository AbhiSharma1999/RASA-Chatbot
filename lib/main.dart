import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rasa_chatbot/pages/Home.dart';

import 'locale/DemoLocalization.dart';
import 'locale/constants.dart';

void main() {
  runApp(MyApp());
}
      
class MyApp extends StatefulWidget {


  static void setLocale(BuildContext context , Locale locale){
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocaleState(locale);
    print("setLocale");
  }
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;


  void setLocaleState(Locale locale){
    setState(() {
      _locale = locale;
      print("setlocalestate setstate");
    });
    String languagecode = locale.languageCode;
    print("setlocalestate $languagecode");
  }


  @override
  void didChangeDependencies() {

    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
    
  }
  
  @override
  Widget build(BuildContext context) {
    return _locale==null?Center(child:CircularProgressIndicator()): MaterialApp(
      title:"Demo",
      locale: _locale,
      theme: ThemeData(primarySwatch: Colors.blue),
      supportedLocales: [
        Locale('en','US'),
        Locale('hi','IN'),
      ],
      localizationsDelegates: [
        DemoLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      // localeResolutionCallback: (deviceLocale,supportedLocales){
      //   for(var locale in supportedLocales){
      //     if(locale.languageCode==deviceLocale.languageCode && locale.countryCode==deviceLocale.countryCode){
      //       print("helllooooooo");
      //       return deviceLocale;
      //     }
      //   }
      //   return supportedLocales.last;
      // },
      debugShowCheckedModeBanner: false,
      home: Home(locale: _locale,),
    );
  }
}