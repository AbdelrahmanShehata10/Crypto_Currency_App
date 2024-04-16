import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/Cubit/appcubit.dart';
import 'package:graduation/Cubit/appstates.dart';
import 'package:hexcolor/hexcolor.dart';

class CryptoCurrency extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return
      BlocConsumer<AppCubit,Appstates>(
        builder: ( context, state) {


          return
            Scaffold(
                         backgroundColor: HexColor('E5E4E2'),

            body:AppCubit.get(context).Screens[AppCubit.get(context).Currentindex],

            bottomNavigationBar: BottomNavigationBar(
              unselectedItemColor: HexColor('50C878'),
              selectedItemColor: HexColor('50C878'),
              showUnselectedLabels: false,
              currentIndex: AppCubit.get(context).Currentindex,
              onTap: (index){
                AppCubit.get(context).ontap(index);
              },
              items: AppCubit.get(context).bottomnavbar,)
            ,
          );

        },
        listener: ( context,  state) {  },
      );
  }
}
