import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/Cubit/appcubit.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Cubit/appstates.dart';
import '../components/Coinsitem.dart';
import '../components/Text.dart';
import 'CryptoCurrency.dart';
import 'Home.dart';

class SearchScreen extends StatelessWidget {
//https://api.coingecko.com/api/v3/search?query=us
  @override
  Widget build(BuildContext context) {

    TextEditingController searchh=TextEditingController();
    return
      BlocConsumer<AppCubit,Appstates>(
        builder: ( context, state) {
          return
            Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                leading:
                InkWell(
                    onTap: (){

                    },
                    child: Icon(Icons.arrow_back_outlined)),
              ),
              body:
              Column(
                children: [
          SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 5,),
            SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width,
              child:
              InkWell(
                onTap: (){
                },
                child: TextField(
                  onChanged: (value){
                    AppCubit.get(context).GetSearch(value);

                  },
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                        onTap: (){

                        },
                        child: InkWell(
                            onTap: (){
                              // searchh.clear();
                            },
                            child: Icon(Icons.close,color: Colors.green,))),
                    // filled: true,
                    fillColor: const Color(0xfff1f1f1),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Search for Coins",
                    hintStyle: Theme.of(context).textTheme.bodyText1,
                    prefixIcon: const Icon(Icons.search,color: Colors.green),
                  ),
                ),
              ),

            ),
            SizedBox(height: MediaQuery.of(context).size.height/4,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child:
                Container(
height: 150,
                    width: 360,
                    child: Center(child: Image.asset("assets/images/zyro-image.png",fit: BoxFit.cover,)))),
                TitleText(Title: 'Search for a coin', fontsize: 25)
              ],
            ),
          ],
        ),
      ),
                  Expanded(child: listofcoinsforsearch(AppCubit.get(context).Search,issearch: true))
                ],
              )
          );

        },
        listener: ( context,  state) {  },
      );
  }
}
