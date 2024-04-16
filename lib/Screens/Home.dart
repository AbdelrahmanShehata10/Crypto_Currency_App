import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/CacheHelper/cache.dart';
import 'package:graduation/Cubit/appcubit.dart';
import 'package:graduation/Cubit/appstates.dart';
import 'package:graduation/applocalization.dart';
import 'package:hexcolor/hexcolor.dart';

import '../components/Coinsitem.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer<AppCubit,Appstates>(
        builder: ( context, state) {
        print('${CacheHelper.get(key: 'lang')}');
          var list=AppCubit.get(context).info;
          return         Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                title:Text(AppLocalization.of(context)!.translatetext('Crypto Currency'),style: Theme.of(context).textTheme.bodyText1,) ,
              ),
              body:
              listofcoins(list)

          );

        },
        listener: ( context,  state) {  },
      );
    ;
  }
}
