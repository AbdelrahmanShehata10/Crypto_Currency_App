// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
//
// class test extends StatelessWidget {
//   const test({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return                           StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('users').snapshots(),
//         builder: (context,snapshot)
//
//         {
// Text
//           // List<Row> users=[];
//           // if(snapshot.hasData){
//           //
//           //   final  user=snapshot.data?.docs.reversed.where((element) {
//           //     final Firebaseuser= FirebaseAuth.instance.currentUser;
//           //
//           //   })
//           //   for(var x in user!){
//           //     final userss=Row(
//           //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //       children: [
//           //         Text('${x['Email']}'),
//           //       ],
//           //     );
//           //     users.add(userss) ;
//           //   }
//           // }
//           // return   Expanded(
//           //   child: ListView(
//           //       children: users
//           //   ),
//           // );
//         })
//     ;
//   }
// }
