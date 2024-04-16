import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation/Cubit/appcubit.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Screens/detailScreen.dart';
Widget buildcoinitem(context,list,number){
  if(list['market_data']['price_change_24h']>0){
    AppCubit.get(context).Color=Colors.green;

  }
  
  else {
    AppCubit.get(context).Color=Colors.red;
  }

  return
    Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: (){

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
                    return DetailsScreen( Cryptocoin: list,);
                  }));

        },
        child: Container(
          height: 80,
          decoration: BoxDecoration(
              color: HexColor('4E5180'),
              borderRadius: BorderRadius.all(Radius.circular(25))
          ),
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:   Text('$number',style: Theme.of(context).textTheme.bodyText1,),
                  ),
                  Container(
                    height: 50,
                    width: 60,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage("${list['image']['small']}")),
                        borderRadius: BorderRadius.all(Radius.circular(25))

                    ),
                  ),
                  SizedBox(width: 8,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('${list['id']}',style: Theme.of(context).textTheme.bodyText1,),
                      const SizedBox(height: 5,),
                      Text('${list['symbol']}',style: Theme.of(context).textTheme.bodyText2,),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text('${list['market_data']['current_price']['usd'].toStringAsExponential(2)}\$',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,overflow: TextOverflow.ellipsis,
                    ),),

                    Text('${list['market_data']['price_change_24h'].toStringAsExponential(2)// 1.000e+21
                    }',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,overflow: TextOverflow.clip,color:  AppCubit.get(context).Color),),

                    Text('${list['market_data']['price_change_percentage_24h'].toStringAsExponential(2) // 1.000e+21
                    } %',maxLines: 5,style: TextStyle(fontSize: 15,overflow: TextOverflow.ellipsis,fontWeight: FontWeight.w400,color:  AppCubit.get(context).Color,),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ));

}
Widget Details(context,list){

  return
    SingleChildScrollView(
    child: Column(
      children: [
        Container(
            height: MediaQuery.of(context).size.height/4,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor
            ),
            child: Image.network("${list['image']['small']}",fit: BoxFit.cover,)),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${list['id']}',style:Theme.of(context).textTheme.headline4 ),

              Row(

                children: [
                  Text('Rank',style:Theme.of(context).textTheme.headline4
                  ),
                  SizedBox(width: 10,),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.grey
                    ),
                    child: Center(child: Text('${list['market_data']['market_cap_rank']}',style: Theme.of(context).textTheme.bodyText2,),),
                  ),
                ],
              ),


            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text('${list['market_data']['current_price']['usd']}\$',style: Theme.of(context).textTheme.bodyText1,overflow: TextOverflow.ellipsis,),
              SizedBox(width: 20,),
              Text('${list['market_data']['price_change_24h']// 1.000e+21
              }',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,overflow: TextOverflow.clip,color:  AppCubit.get(context).Color),),

            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Description',style: Theme.of(context).textTheme.headline4,overflow: TextOverflow.ellipsis,),
              Text('${list['market_data']['Description']}',style: Theme.of(context).textTheme.headline4,overflow: TextOverflow.ellipsis,),
            ],
          ),
        )
      ],
    ),
  );

}
Widget buildcoinitemforsearch(context,list,number){
  // if(list['market_data']['price_change_24h']>0){
  //   AppCubit.get(context).Color=Colors.green;
  //
  // }

  // else
  //   AppCubit.get(context).Color=Colors.red;

  return     Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: (){

        },
        child: Container(
          height: 80,
          decoration: BoxDecoration(
              color: HexColor('4E5180'),
              borderRadius: BorderRadius.all(Radius.circular(25))
          ),
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:   Text('$number',style: Theme.of(context).textTheme.bodyText1,),
                  ),
                  Container(
                    height: 50,
                    width: 60,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage("${list['thumb']}")),
                        borderRadius: BorderRadius.all(Radius.circular(25))

                    ),
                  ),
                  SizedBox(width: 8,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('${list['id']}',style: Theme.of(context).textTheme.bodyText1,),
                      const SizedBox(height: 5,),
                      Text('${list['symbol']}',style: Theme.of(context).textTheme.bodyText2,),
                    ],
                  ),
                ],
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8),
              //   child: Column(
              //     children: [
              //       Text('${list['market_data']['current_price']['usd'].toStringAsExponential(2)}\$',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,overflow: TextOverflow.ellipsis,
              //       ),),
              //
              //       Text('${list['market_data']['price_change_24h'].toStringAsExponential(2)// 1.000e+21
              //       }',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,overflow: TextOverflow.clip,color:  AppCubit.get(context).Color),),
              //
              //       Text('${list['market_data']['price_change_percentage_24h'].toStringAsExponential(2) // 1.000e+21
              //       } %',maxLines: 5,style: TextStyle(fontSize: 15,overflow: TextOverflow.ellipsis,fontWeight: FontWeight.w400,color:  AppCubit.get(context).Color,),
              //       )
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ));

}
Widget listofcoins(list,{issearch=false})=>
    ConditionalBuilder(
    condition: list.length>0, builder: (context)=>ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context,index)=>

        buildcoinitem(context,list[index],++index),
    separatorBuilder:(context,index)=> Divider(
      color: Colors.grey,
      thickness: 2,
    ), itemCount: list.length),
        fallback:(context)=> issearch ? Container() : Center(child: CircularProgressIndicator()));
 // Widget builddetails(list,{issearch=false})=>          ConditionalBuilder(
 //     condition: list.length>0, builder: (context){
 //   return  ListView.builder(
 //     itemCount: 1,
 //
 //       itemBuilder: (BuildContext context, int index) { return
 //
 //         Details(context, list,index); },
 //    );
 // },
 //
 //
 //     fallback:(context)=>  Center(child: CircularProgressIndicator()));

Widget listofcoinsforsearch(list,{issearch=false})=>          ConditionalBuilder(
    condition: list.length>0, builder: (context)=>ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context,index)=>

        buildcoinitemforsearch(context,list[index],++index),
    separatorBuilder:(context,index)=> Divider(
      color: Colors.grey,
      thickness: 2,
    ), itemCount: list.length), fallback:(context)=> issearch ? Container() : Center(child: CircularProgressIndicator()));
