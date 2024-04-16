
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:graduation/l10n/L10n.dart';
import 'package:hexcolor/hexcolor.dart';

import 'API/DioHelper.dart';
import 'CacheHelper/cache.dart';
import 'Cubit/appcubit.dart';
import 'Cubit/appstates.dart';
import 'Cubit/blocobserver.dart';
import 'Screens/CryptoCurrency.dart';
import 'Screens/Home.dart';
import 'Screens/Profile.dart';
import 'Screens/Search.dart';
import 'Screens/authscreen.dart';
import 'Screens/detailScreen.dart';
import 'Screens/signup.dart';
import 'Screens/test.dart';
import 'applocalization.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  Widget ?widget;
  bool? isdark=CacheHelper.get(key: 'isdark') as bool? ;
  String? token=CacheHelper.get(key: 'Email') as String?;
  if(token !=null){
    widget=CryptoCurrency();

  }
  else{
    widget=authScreen();
  }
  runApp( MyApp(isdark,widget));
}

class MyApp extends StatelessWidget {

  final bool ?isdark;
  final Widget StartWidget;
  MyApp(this.isdark,this.StartWidget);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return

      MultiBlocProvider(
        providers:[
          BlocProvider(create: (context)=>AppCubit()..getdetailinfo()..darkmode(fromshared: isdark)..getuserinfo()..applangfunc(languageenums.initiallanguage))
        ],
        child: BlocConsumer<AppCubit,Appstates>(
          builder: ( context, state) {
            if(state is Appchangelang){
              return
                MaterialApp(
                debugShowCheckedModeBanner: false,
                locale: Locale(state.langcode!),
                  localizationsDelegates: [
                    AppLocalization.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  localeResolutionCallback:(devicelocale,supportedLocales){
                    for(var locale in supportedLocales){
                      if(devicelocale !=null)
                      {
                        if(devicelocale.languageCode==locale.languageCode ){
                          return devicelocale;
                        }
                      }
                      else
                      {
                        return supportedLocales.first;
                      }
                    }
                  } ,
                  supportedLocales: [
                    Locale('en'),
                    Locale('ar'),

                  ],
                themeMode: AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light,
                theme:
                ThemeData(

                    backgroundColor: HexColor('E5E4E2'),
                    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                        type: BottomNavigationBarType.fixed
                    ),
                    appBarTheme:
                    AppBarTheme(
                      backgroundColor: Colors.transparent,
                      textTheme: TextTheme(

                        headline4: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                        bodyText2: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white

                        ),

                        bodyText1: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                        ),
                      ),
                      iconTheme: IconThemeData(
                          color: Colors.black
                      ),
                      backwardsCompatibility: false,
                      systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: Colors.transparent,
                          statusBarBrightness: Brightness.dark
                      ),
                      elevation: 0.0,
                      titleTextStyle:TextStyle(color: Colors.blueAccent,fontSize: 30,fontWeight: FontWeight.bold) ,
                    )

                ),
                darkTheme:
                ThemeData(
                    backgroundColor: HexColor('333739'),
                    textTheme:  TextTheme(
                        headline4: TextStyle(
                          color: Colors.white,

                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),

                        bodyText2: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white

                        ),
                        bodyText1: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white
                        )
                    ),
                    appBarTheme: AppBarTheme(
                        iconTheme: IconThemeData(
                            color: Colors.white
                        ),
                        backwardsCompatibility: false,
                        systemOverlayStyle: SystemUiOverlayStyle(
                            statusBarColor: HexColor("333739"),
                            statusBarBrightness: Brightness.light
                        ),
                        elevation: 0.0,
                        titleTextStyle:const TextStyle(color: Colors.blueAccent,fontSize: 30,fontWeight: FontWeight.bold) ,
                        backgroundColor: HexColor("333739")
                    ),

                    bottomNavigationBarTheme: BottomNavigationBarThemeData(
                        type: BottomNavigationBarType.fixed,
                        backgroundColor: HexColor("333739")
                    ),
                    scaffoldBackgroundColor:HexColor("333739")
                ),

                home: StartWidget,
              );

            }
            return
              MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light,
              theme:
              ThemeData(

backgroundColor: HexColor('E5E4E2'),
                  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed
                  ),
                  appBarTheme:
                   AppBarTheme(
backgroundColor: Colors.transparent,
                      textTheme: TextTheme(

                        headline4: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                        bodyText2: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white

                        ),

                        bodyText1: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                        ),
                      ),
                      iconTheme: IconThemeData(
                          color: Colors.black
                      ),
                      backwardsCompatibility: false,
                      systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: Colors.transparent,
                          statusBarBrightness: Brightness.dark
                      ),
                      elevation: 0.0,
                    titleTextStyle:TextStyle(color: Colors.blueAccent,fontSize: 30,fontWeight: FontWeight.bold) ,
                  )

              ),
              darkTheme:
              ThemeData(
                backgroundColor: HexColor('333739'),
                  textTheme:  TextTheme(
                      headline4: TextStyle(
                        color: Colors.white,

                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),

                    bodyText2: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                        color: Colors.white

                    ),
                      bodyText1: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                      )
                  ),
                  appBarTheme: AppBarTheme(
                      iconTheme: IconThemeData(
                          color: Colors.white
                      ),
                      backwardsCompatibility: false,
                      systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: HexColor("333739"),
                          statusBarBrightness: Brightness.light
                      ),
                      elevation: 0.0,
                      titleTextStyle:const TextStyle(color: Colors.blueAccent,fontSize: 30,fontWeight: FontWeight.bold) ,
                      backgroundColor: HexColor("333739")
                  ),

                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      backgroundColor: HexColor("333739")
                  ),
                  scaffoldBackgroundColor:HexColor("333739")
              ),
                localizationsDelegates: [
                  AppLocalization.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
localeResolutionCallback:(devicelocale,supportedLocales){
for(var locale in supportedLocales){
  if(devicelocale !=null){
    if(devicelocale.languageCode==locale.languageCode ){
return devicelocale;
    }
  }
  return supportedLocales.first;
}
} ,
supportedLocales: [
  Locale('ar'),
  Locale('en'),

],
              home: StartWidget,
            );

          },
          listener: ( context,  state) {  },
        ),
      );
  }
}


