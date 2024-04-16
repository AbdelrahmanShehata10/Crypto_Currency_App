import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/Cubit/appcubit.dart';
import 'package:graduation/Cubit/appstates.dart';
import 'package:graduation/Screens/CryptoCurrency.dart';

import '../components/Coinsitem.dart';

class DetailsScreen extends StatelessWidget {
  final Cryptocoin;
  DetailsScreen({
  required this.Cryptocoin
});
  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer<AppCubit,Appstates>(
        builder: (BuildContext context, state) {
          var list=AppCubit.get(context).info;

          return         Scaffold(
            appBar: AppBar(
              leading: IconButton(onPressed: (){
                Navigator.pushReplacement(context,
                    PageRouteBuilder(
                        transitionDuration: Duration(seconds: 2),
                        transitionsBuilder:(context,animation,animationTime,child){
                          animation=CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
                          return
                            ScaleTransition(
                                alignment: Alignment.center,
                                child: child,
                                scale: animation);
                        } ,
                        pageBuilder: (context,animation,animationTime){
                          return CryptoCurrency();
                        }));
              }, icon: Icon(Icons.arrow_back_outlined)),
            ),
            backgroundColor: Theme.of(context).backgroundColor,
            body:Details(context,Cryptocoin),

          );

        },
        listener: (BuildContext context, Object? state) {

        },
      );
  }
}
