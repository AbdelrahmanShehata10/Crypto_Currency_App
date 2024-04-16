import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:graduation/API/DioHelper.dart';
import 'package:graduation/CacheHelper/cache.dart';
import 'package:graduation/Screens/Home.dart';
import 'package:graduation/Screens/Profile.dart';
import 'package:graduation/Screens/Search.dart';
import 'package:graduation/Screens/test.dart';
import 'package:graduation/l10n/L10n.dart';
import 'package:graduation/models/usermodel.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

import '../Screens/CryptoCurrency.dart';
import '../Screens/authscreen.dart';
import '../Services.dart';
import '../applocalization.dart';
import 'appstates.dart';

class AppCubit extends Cubit<Appstates> {
  AppCubit() : super(initial());
  //بده هقدر احدد انهي حته في الكيوبت انا عايزها
  static AppCubit get(context) => BlocProvider.of(context);
  var services = AUTHSTORE();
  String url = '';
  File? profileiamgefile;
  final _imagepicker = ImagePicker();
  Future<void> takepic(ImageSource source) async {
    final profileimage = await _imagepicker.pickImage(source: source);

    profileiamgefile = File(profileimage!.path);
    emit(Takedpic());
    uploadimage();
  }

  Future<String?> uploadimage() async {
    try {
      print(profileiamgefile!.path);
      UploadTask uploadTask;
      Reference ref =
          FirebaseStorage.instance.ref().child(profileiamgefile!.path);
      uploadTask = ref.putFile(File(profileiamgefile!.path));
      await uploadTask.whenComplete(() async {
        url = await ref.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(CacheHelper.get(key: 'uid').toString())
            .update({'url': url});

        model.url = url;
        print(url);
      });

      emit(UploadedDone());
    } catch (e) {
      print(e);
      emit(unUploadedDone());
    }
  }

  signinWithGoogle(context) async {
    GoogleSignInAccount? Googleuser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleauth =
        await Googleuser?.authentication as GoogleSignInAuthentication?;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleauth!.accessToken,
      idToken: googleauth.idToken,
    );
    UserCredential? userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (userCredential.user!.uid != null) {
      CacheHelper.savedata_tosharedpref('Email', userCredential.user!.email);
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              transitionDuration: Duration(seconds: 2),
              transitionsBuilder: (context, animation, animationTime, child) {
                animation = CurvedAnimation(
                    parent: animation, curve: Curves.elasticInOut);
                return ScaleTransition(
                    alignment: Alignment.center,
                    scale: animation,
                    child: child);
              },
              pageBuilder: (context, animation, animationTime) {
                return CryptoCurrency();
              }));
    }
    print(userCredential.user!.uid);
    emit(GoogleSignedinDone());
  }

  final FirebaseStorage storge = FirebaseStorage.instance;

  // dynamic uid=CacheHelper.get(key: 'uid');

  MaterialColor? Color;
  int Currentindex = 0;
  List<dynamic> info = [];
  List<Widget> Screens = [
    HomeScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];
  List<BottomNavigationBarItem> bottomnavbar = [
    BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
    BottomNavigationBarItem(label: 'Search', icon: Icon(Icons.search)),
    BottomNavigationBarItem(label: 'Profile', icon: Icon(Icons.person))
  ];
  void ontap(index) {
    Currentindex = index;
    emit(bottomnav());
  }

  void FirebaseSignin(
    context, {
    required String Email,
    required dynamic password,
  }) async {
    emit(Loginloading());
    try {
      await services.auth
          .signInWithEmailAndPassword(email: Email, password: password)
          .then((value) {
        if (value.user!.uid != null) {
          CacheHelper.savedata_tosharedpref('Email', value.user!.email);
          CacheHelper.savedata_tosharedpref('uid', value.user!.uid);
          Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  transitionDuration: Duration(seconds: 2),
                  transitionsBuilder:
                      (context, animation, animationTime, child) {
                    animation = CurvedAnimation(
                        parent: animation, curve: Curves.elasticInOut);
                    return ScaleTransition(
                        alignment: Alignment.center,
                        child: child,
                        scale: animation);
                  },
                  pageBuilder: (context, animation, animationTime) {
                    return CryptoCurrency();
                  }));
          getuserinfo();
        }
      });
      final notify1 = SnackBar(
          backgroundColor: HexColor('50C878'),
          content: Text(
            'Login Successfully',
            style: TextStyle(
                color: HexColor('151B8D'),
                fontSize: 15,
                fontWeight: FontWeight.w600),
          ));
      ScaffoldMessenger.of(context).showSnackBar(notify1);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      emit(LoginFailed());
      final notify2 = SnackBar(
          backgroundColor: HexColor('50C878'),
          content: Text(
            '${e}',
            style: TextStyle(
                color: HexColor('151B8D'),
                fontSize: 15,
                fontWeight: FontWeight.w600),
          ));
      ScaffoldMessenger.of(context).showSnackBar(notify2);
    }
  }

  String? uid;
  usermodel model = usermodel();

  Future FirebaseSignup(
    context, {
    required String name,
    required String Email,
    required dynamic password,
  }) async {
    emit(Signuploading());
    try {
      await services.auth
          .createUserWithEmailAndPassword(email: Email, password: password)
          .then((value) async {
        uid = value.user?.uid;

        if (value.user?.uid != null) {
          CacheHelper.savedata_tosharedpref('uid', value.user?.uid);
          model = usermodel(
            Name: name,
            uid: uid,
            Email: Email,
          );
          Adduserdetails(name, Email, url);
          Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  transitionDuration: Duration(seconds: 2),
                  transitionsBuilder:
                      (context, animation, animationTime, child) {
                    animation = CurvedAnimation(
                        parent: animation, curve: Curves.elasticInOut);
                    return ScaleTransition(
                        alignment: Alignment.center,
                        child: child,
                        scale: animation);
                  },
                  pageBuilder: (context, animation, animationTime) {
                    return authScreen();
                  }));
        } else {
          Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  transitionDuration: Duration(seconds: 2),
                  transitionsBuilder:
                      (context, animation, animationTime, child) {
                    animation = CurvedAnimation(
                        parent: animation, curve: Curves.elasticInOut);
                    return ScaleTransition(
                        alignment: Alignment.center,
                        child: child,
                        scale: animation);
                  },
                  pageBuilder: (context, animation, animationTime) {
                    return authScreen();
                  }));
        }

        print(uid);
        print('10000000000000000000000000000000000000000000');
      });
      emit(SignupSuccess());
      final notify1 = SnackBar(
          backgroundColor: HexColor('50C878'),
          content: Text(
            'Welcome to our App',
            style: TextStyle(
                color: HexColor('151B8D'),
                fontSize: 15,
                fontWeight: FontWeight.w600),
          ));
      ScaffoldMessenger.of(context).showSnackBar(notify1);
    } on FirebaseAuthException catch (e) {
      emit(SignupFailed());
      final notify2 = SnackBar(
          backgroundColor: HexColor('50C878'),
          content: Text(
            '${e}',
            style: TextStyle(
                color: HexColor('151B8D'),
                fontSize: 15,
                fontWeight: FontWeight.w600),
          ));
      ScaffoldMessenger.of(context).showSnackBar(notify2);
    }
  }

  Future Adduserdetails(Name, Email, url) async {
    var Firebaseuser = await FirebaseAuth.instance.currentUser!;
    print(uid);
    print('88888888888888888888888888888888888888');
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(
          model!.tomap(),
        )
        .then((value) {
      emit(useraddedsucssefully());
    });
  }

  getdetailinfo() {
    emit(infoloading());
    DioHelper.getdata(url: "api/v3/coins/", Query: {'vs_currency': 'usd'})
        .then((value) {
// print(value?.data);
      info = value?.data;
      // debugPrint('${info[0]['url']}');
      emit(infoSuccess());
    }).catchError((e) {
      print(e.toString());
      emit(infoFailed(e));
    });
  }

  List<dynamic> Search = [];
  GetSearch(String value) {
    try {
      DioHelper.getdata(url: '/api/v3/search', Query: {'query': value})
          .then((value) async {
        Search = value?.data["coins"];
        print(Search);
        emit(SearchSucceded());
      });
    } catch (e) {
      print(e);
      emit(SearchFailed());
    }
  }

  bool isdark = false;
  darkmode({fromshared}) {
    if (fromshared != null) {
      isdark = fromshared;
    } else {
      isdark = !(isdark);
      CacheHelper.putbool(key: 'isdark', value: isdark);
    }
    emit(appchangemodestate());
  }

  Logout(context) async {
    await services.auth.signOut().then((value) {
      CacheHelper.sharedPreferences!.remove('Email');
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              transitionDuration: Duration(seconds: 2),
              transitionsBuilder: (context, animation, animationTime, child) {
                animation = CurvedAnimation(
                    parent: animation, curve: Curves.elasticInOut);
                return ScaleTransition(
                    alignment: Alignment.center,
                    child: child,
                    scale: animation);
              },
              pageBuilder: (context, animation, animationTime) {
                return authScreen();
              }));
    });
  }

  List users = [];
  // void getuserdata(){
  //   emit(getuserdataloading());
  //   FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
  //    print(value.data());
  //     emit(getuserdatadone());
  //   });
  // }
  void getuserinfo() async {
    emit(getuserdataloading());

    await FirebaseFirestore.instance
        .collection('users')
        .doc(CacheHelper.get(key: 'uid').toString())
        .get()
        .then((value) {
      model = usermodel.fromjson(value.data()!);
      print(model.url);
      print('0000000000000000000000000000000');

      emit(getuserdatadone());
    }).catchError((onError) {
      print(onError);
      emit(getuserdatafailed());
    });
    print('+++');
    print(model.Name);
    print('---------------------------');
    print(model.uid);
    print('uuuuuuuuuuuuuuuuuuuuuuu');

    print(model.Email);
  }

  applangfunc(languageenums cases) {
    switch (cases) {
      case languageenums.initiallanguage:
        if (CacheHelper.get(key: 'lang') != null) {
          print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
          if (CacheHelper.get(key: 'lang') == 'ar') {
            emit(Appchangelang(langcode: 'ar'));
            print('arrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
          } else {
            emit(Appchangelang(langcode: 'en'));
            print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxr');
          }
        }
        break;
      case languageenums.arabic:
        CacheHelper.savedata_tosharedpref('lang', 'ar');
        emit(Appchangelang(langcode: 'ar'));
        break;
      case languageenums.english:
        CacheHelper.savedata_tosharedpref('lang', 'en');
        emit(Appchangelang(langcode: 'en'));

        break;

      default:
    }
  }
}
