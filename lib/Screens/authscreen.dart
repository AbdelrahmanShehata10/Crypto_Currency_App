
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/Screens/signup.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Cubit/appcubit.dart';
import '../Cubit/appstates.dart';
import '../components/Spaces.dart';
import '../components/Text.dart';
import '../components/buttons.dart';
import 'CryptoCurrency.dart';

class authScreen extends StatelessWidget {
  TextEditingController email=TextEditingController();
  TextEditingController name=TextEditingController();
  TextEditingController password=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return

      BlocConsumer<AppCubit,Appstates>(
        builder: ( context, state) {

          return         Scaffold(
            backgroundColor:  Theme.of(context).backgroundColor,

            body:

                
            SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(child: TitleText(Title: 'Sign in', fontsize: 28)),
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

                              button(title: 'Sign in', color: HexColor('50C878'), height: 30, width: 250,  titlecolor: HexColor('F5F5F5'), path: '', function: (){


                                AppCubit.get(context).FirebaseSignin(context, Email: email.text, password: password.text);
                                email.clear();
                                password.clear();
                              }),
                            ],
                          ),
                        ),
                        sizedbox(),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 40,),

                            Center(child: TitleText(Title: 'OR', fontsize: 20)),

                          ],
                        ),
                        sizedbox(),
                        // SizedBox(width: 42,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 40,),
                            button(title: 'Continue With Google', color: HexColor('50C878'), height: 30, width: 240, titlecolor: HexColor('F5F5F5'), path: '', function: (){
                              AppCubit.get(context).signinWithGoogle(context);


                            })

                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 40,),

                            TitleText(Title: 'if you have an account? ', fontsize: 15),
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
                                        return signupscreen();
                                      }));
                            }, child:
                            Text('Sign up',style: TextStyle(
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
            ),
          );

        },
        listener: (BuildContext context, Object? state) {  },
      );

  }
}
