import 'package:dio/dio.dart';

class DioHelper{
  static Dio ?dio;
  static init(){
    dio=Dio(BaseOptions(
      baseUrl:"https://api.coingecko.com/",
receiveDataWhenStatusError: true)
    );
  }
  //لما اجيب داتا في الهيلبر لازم تكون من النوع ريسبونس
  static Future<Response?> getdata({
    required String url,
    required dynamic Query

})async{
   return await dio?.get(url,queryParameters: Query);
  }
}