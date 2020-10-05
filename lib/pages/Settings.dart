import 'package:flutter/material.dart';
import 'package:rasa_chatbot/locale/constants.dart';
import 'package:rasa_chatbot/models/language_model.dart';

import '../main.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {


  void _changeLanguage(Language language) async{
    Locale _locale=await setLocaleinMemory(language.languagecode);
    print("_changeLanguage(Language language)");

    MyApp.setLocale(context,_locale);
    
  }


  @override
  Widget build(BuildContext context) {
    return Container(
         decoration: BoxDecoration(
     gradient: LinearGradient(
       begin: Alignment.topCenter,
       end: Alignment.bottomCenter,
       colors: [
         Color(0xff053f5e),
         Color(0xff022c43)
       ]
     )
         ),
         child: Scaffold(
           backgroundColor: Colors.transparent,
           body: Center(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               children: <Widget>[
                
                Spacer(),


                 SizedBox(
                   height: MediaQuery.of(context).size.height*0.75,
                   child: ListView.builder(
                     physics: BouncingScrollPhysics(),
                     itemCount: 2,
                     itemBuilder: (BuildContext context,int i){
                       return Padding(
                       padding: EdgeInsets.only(left:MediaQuery.of(context).size.width/5,right: MediaQuery.of(context).size.width/5),
                       child: GestureDetector(
                         onTap: (){
                           _changeLanguage(Language.languageList[i]);
                           Navigator.pop(context);
                         },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom:8.0),
                              child: Card(
                                elevation: 15,
                                color: Color(0xffffd700),
                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Container(child:Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                Language.languageList[i].name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xff115173),
                                  fontSize: 18
                                ),
                                ),
                          ))
                    ),
                            ),
                       ),
                     );
                     }
                  ),
                 ),

                Padding(
                   padding: const EdgeInsets.only(bottom:18.0,top: 18),
                   child: IconButton(icon: Icon(Icons.cancel,size: 45,color:Color(0xffffd700)), 
                   onPressed: (){Navigator.pop(context);},
                   )
                 ),

               ],
             ),
           ),
         )
    );
  }
}