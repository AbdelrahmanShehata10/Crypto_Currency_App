import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
class AppLocalization{
   Locale ?locale;
   AppLocalization({
     this.locale
});
   static AppLocalization? of(context){
     return Localizations.of<AppLocalization>(context, AppLocalization);

   }
   static LocalizationsDelegate<AppLocalization> delegate=applocalizDelegate();

   late Map<String,String> jsonStrings;

Future loadLangJson()async{
  String strings=await rootBundle.loadString('assets/lang/${locale!.languageCode}.json');
  Map<String,dynamic>jsons=  json.decode(strings);
  jsonStrings=jsons.map((key, value) {
    return MapEntry(key, value.toString());
  });
}
String translatetext(String key){
 return jsonStrings[key] ?? '';
}
}
class applocalizDelegate extends LocalizationsDelegate<AppLocalization>{
  @override
  bool isSupported(Locale locale) {
    return ['en','ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale)async {
    AppLocalization appLocalization =AppLocalization(locale: locale);
  await appLocalization.loadLangJson();
  return appLocalization;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) =>false;

}