
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Cubit/appcubit.dart';
import '../Cubit/appstates.dart';
import '../components/Spaces.dart';
import '../components/Text.dart';
import '../components/buttons.dart';
import 'authscreen.dart';

class signupscreen extends StatelessWidget {
  TextEditingController email=TextEditingController();
  TextEditingController name=TextEditingController();
  TextEditingController password=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return

      BlocConsumer<AppCubit,Appstates>(
        builder: (BuildContext context, state) {
          return         Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body:
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child:
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),

                  child:

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height/5,),
                      Center(child: TitleText(Title: 'Sign up', fontsize: 28)),
                      sizedbox(),
                      Center(
                        child: Container(
                          // height: 50,
                          // width: 300,
                            child: NormalTextfield(icon: Icon(Icons.person), iconcolor: Colors.grey, hintText: 'name', email: name)),
                      ),
                      sizedbox(),

                      Center(
                        child: Container(
                          // height: 50,
                          // width: 300,
                            child: NormalTextfield(icon: Icon(Icons.email), iconcolor: Colors.grey, hintText: 'Email', email: email)),
                      ),
                      sizedbox(),
                      Container(
                        // height: 50,
                        // width: 300,
                          child: PasswordTextfield(icon: Icon(Icons.password), iconcolor: Colors.grey, hintText: 'Password', password: password))
                      ,
                      sizedbox(),

                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center
                          ,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 40,),

                            button(title: 'Sign up', color: HexColor('50C878'), height: 30, width: 250,  titlecolor: HexColor('F5F5F5'), path: '', function: (){


                              AppCubit.get(context).FirebaseSignup(context, name: name.text, Email: email.text, password: password.text);

                            }),


                          ],
                        ),
                      ),
                      sizedbox(),

                      // SizedBox(width: 42,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 40,),

                          TitleText(Title: 'Already have an account? ', fontsize: 15),
                          TextButton(onPressed: (){
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
                                      return authScreen();
                                    }));
                          }, child: Text('Login',style: TextStyle(
                            fontSize: 15,
                            color: HexColor('50C878'),
                          ),))

                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );

        },
        listener: (BuildContext context, Object? state) {  },
      );
  }
}
