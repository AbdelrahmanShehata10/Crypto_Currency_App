import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/CacheHelper/cache.dart';
import 'package:graduation/Cubit/appcubit.dart';
import 'package:graduation/Cubit/appstates.dart';
import 'package:graduation/components/buttons.dart';
import 'package:graduation/l10n/L10n.dart';
import 'package:graduation/models/usermodel.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

import '../applocalization.dart';

class ProfileScreen extends StatelessWidget {

  usermodel model=usermodel();
  Uint8List ?file;
  TextEditingController email=TextEditingController();
  TextEditingController name=TextEditingController();
  TextEditingController password=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer<AppCubit,Appstates>(
        builder: (BuildContext context, state) {
          return
            Scaffold(
appBar: AppBar(

),
              backgroundColor: Theme.of(context).backgroundColor,

              body:Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SafeArea(child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Container(
                        padding: EdgeInsets.all(5), // Border width
                        decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                        child: ClipOval(

                          child: SizedBox.fromSize(
                            size: Size.fromRadius(70), // Image radius
                            child: AppCubit.get(context).profileiamgefile == null ? Image.asset('assets/images/user.png') :
                            Image.network('${AppCubit.get(context).model.url}',fit: BoxFit.cover,)
                             // Image.file(AppCubit.get(context).profileiamgefile!,fit: BoxFit.cover,)
                            // Image.asset('assets/images/user.png'),
                          ),
                        ),
                      )
                    ],
                  )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          // StreamBuilder<QuerySnapshot>(
                          //     stream: FirebaseFirestore.instance.collection('users').snapshots(),
                          //     builder: (context,snapshot)
                          //
                          //     {
                          //       List<Row> users=[];
                          //       if(snapshot.hasData){
                          //       final  user=snapshot.data?.docs.reversed.toList();
                          //      for(var x in user!){
                          //        final userss=Row(
                          //          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //          children: [
                          //            Text('${x['Email']}'),
                          //          ],
                          //        );
                          //       users.add(userss) ;
                          //      }
                          //       }
                          //    return  Text('${users.toString()}');
                          //     })
Text('${AppCubit.get(context).model.Email}',style: Theme.of(context).textTheme.bodyText1,),
Text('${AppCubit.get(context).model.Name}',style: Theme.of(context).textTheme.bodyText2,)     ,
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        button(title: '${AppLocalization.of(context)!.translatetext('From Gallery')}', titlecolor: HexColor('FFFEFA'), color: HexColor('778899'), height: 30, width: MediaQuery.of(context).size.width/2.1, path: 'path', function: (){AppCubit.get(context).takepic(ImageSource.gallery);

                        }
          )
                        ,button(title: '${AppLocalization.of(context)!.translatetext('Add Photo')}', titlecolor: HexColor('FFFEFA'), color: HexColor('778899'), height: 30, width: MediaQuery.of(context).size.width/2.1, path: 'path', function: () async {AppCubit.get(context).takepic(ImageSource.camera);

                        await FirebaseFirestore.instance.collection('users').doc(CacheHelper.get(key: 'uid').toString()).update({
                          'url':AppCubit.get(context).url
                        });
    })

                      ],
                    ),
                  ),
                  SizedBox(height: 6,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        button(title: '${AppLocalization.of(context)!.translatetext('Change Theme')}', titlecolor: HexColor('FFFEFA'), color: HexColor('778899'), height: 30, width: MediaQuery.of(context).size.width/1.1, path: 'path', function: () async {
                          await AppCubit.get(context).darkmode();

                        })
                      ],
                    ),
                  ),
                  SizedBox(height: 6,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onDoubleTap: (){
                             AppCubit.get(context).applangfunc(languageenums.english);

                          },
                          child: button(title: '${AppLocalization.of(context)!.translatetext('Change Language')}', titlecolor: HexColor('FFFEFA'), color: HexColor('778899'), height: 30, width: MediaQuery.of(context).size.width/1.1, path: 'path', function: (){
                          AppCubit.get(context).applangfunc(languageenums.arabic);
                            // AppCubit.get(context).getuserinfo();
                          }),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 6,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        button(title: '${AppLocalization.of(context)!.translatetext('Log Out')}', titlecolor: HexColor('FFFEFA'), color: HexColor('778899'), height: 30, width: MediaQuery.of(context).size.width/1.1, path: 'path', function: (){
                          AppCubit.get(context).Logout(context);
                     email.clear();
                         password.clear();
                        })
                      ],
                    ),
                  ),

                ],
              )
          );

        },
        listener: (BuildContext context, Object? state) {  },
      );
    ;
  }
}
