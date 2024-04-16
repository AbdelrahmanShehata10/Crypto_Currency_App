import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static SharedPreferences ?sharedPreferences;
  static init() async {
    sharedPreferences=await SharedPreferences.getInstance();
  }
  static Future<bool?> putbool(
  {
    required String key,
    required dynamic value
})async{
    return await sharedPreferences?.setBool(key, value);
  }
  static  Object? get({
    required String key
})
  {
    return sharedPreferences?.get(key);
  }
  static Future savedata_tosharedpref(String key,dynamic value) async {
    if(value is String){
      return await sharedPreferences!.setString(key,value);
    }

    if(value is double){
      return await sharedPreferences!.setDouble(key,value);

    }
    if(value is int){
      return await sharedPreferences!.setInt(key,value);

    }
    if(value == null){
      return await sharedPreferences!.setString(key,value.toString());

    }

}
}