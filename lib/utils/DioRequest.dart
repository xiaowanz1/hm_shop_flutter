// 基于DIo进行二次封装

import 'package:dio/dio.dart';
import 'package:hm_shop_flutter/constants/index.dart';

class Diorequest {
  final _dio = Dio(); //Dio请求对象
  // 配置基础地址和超时时间
  Diorequest(){
    _dio.options
    ..baseUrl = GlobalConstants.BASE_URL
    ..connectTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
    ..sendTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
    ..receiveTimeout = Duration(seconds: GlobalConstants.TIME_OUT);
    _addInterceptor();
  }
  // 添加拦截器
  void _addInterceptor(){
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (request, handler){
        handler.next(request);
      },
      onResponse: (response, handler) {
        //处理不同的http状态码
        if(response.statusCode! >= 200 && response.statusCode! <= 300){
          handler.next(response);
        }else{
          handler.reject(DioException(requestOptions: response.requestOptions));
        }
      },
      onError: (error, handler)  {
        handler.reject(error);
      },
    ));
  }

  //get
 Future<dynamic> get(String url, {Map<String, dynamic>? params}){
    return _handleResponse(_dio.get(url,queryParameters: params));
  }

  //处理返回结果的函数,接受的是还未完成的请求task
  Future<dynamic> _handleResponse(Future<Response<dynamic>> task) async{
    try {
       Response<dynamic> res =  await task;
    final data =  res.data as Map<String,dynamic>;//才是接口返回的真实数据
    if(data['code'] == GlobalConstants.SUCCESS_CODE){
      //说明http状态和业务状态都正常，就可以正常放行
      return data["result"]; //只要result
    }
    //抛出异常
      throw Exception(data["msg"] ?? "加载数据异常");
    } catch (e) {
      throw Exception(e);
    }
  }
}

final dioRequest = Diorequest(); //单例对象

//dio请求工具发出请求返回的数据 存在Response<dynamic>，需要用Response<dynamic>.data取出
// 把所有的接口的data结构出来，拿到真正的数据，要判断业务状态码是否等于1，