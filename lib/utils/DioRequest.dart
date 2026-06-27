// 基于DIo进行二次封装

import 'package:dio/dio.dart';
import 'package:hm_shop_flutter/constants/index.dart';
import 'package:hm_shop_flutter/stores/TokenManager.dart';

class Diorequest {
  final _dio = Dio(); //Dio请求对象
  // 配置基础地址和超时时间
  Diorequest() {
    _dio.options
      ..baseUrl = GlobalConstants.BASE_URL
      ..connectTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
      ..sendTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
      ..receiveTimeout = Duration(seconds: GlobalConstants.TIME_OUT);
    _addInterceptor();
  }
  // 添加拦截器
  void _addInterceptor() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) {
          //注入token 请求头中的Authorization = "Bearer token"
          if(tokenManager.getToken().isNotEmpty){
            request.headers = {
              "Authorization":"Bearer ${tokenManager.getToken()}"
            };
          }
          handler.next(request);
        },
        onResponse: (response, handler) {
          //处理不同的http状态码
          if (response.statusCode! >= 200 && response.statusCode! <= 300) {
            handler.next(response);
          } else {
            handler.reject(
              DioException(requestOptions: response.requestOptions),
            );
          }
        },
        onError: (error, handler) {
          // handler.reject(error);
          handler.reject(
            DioException(
              requestOptions: error.requestOptions,
              message: error.response?.data["msg"] ?? "",
            ),
          );
        },
      ),
    );
  }

  //get
  Future<dynamic> get(String url, {Map<String, dynamic>? params}) {
    return _handleResponse(_dio.get(url, queryParameters: params));
  }

  //post -- 登录
  Future<dynamic> post(String url, {Map<String, dynamic>? data}) {
    return _handleResponse(_dio.post(url, data: data));
  }

  //处理返回结果的函数,接受的是还未完成的请求task
  Future<dynamic> _handleResponse(Future<Response<dynamic>> task) async {
    try {
      Response<dynamic> res = await task;
      final data = res.data as Map<String, dynamic>; //才是接口返回的真实数据
      if (data['code'] == GlobalConstants.SUCCESS_CODE) {
        //说明http状态和业务状态都正常，就可以正常放行
        return data["result"]; //只要result
      }
      //抛出异常
      //throw Exception(data["msg"] ?? "加载数据异常");
      throw DioException(
        requestOptions: res.requestOptions,
        message: data["msg"] ?? "加载数据失败",
      );
    } catch (e) {
      // throw Exception(e);
      rethrow; //不改变原来抛出的异常类型，是DioException
    }
  }
}

final dioRequest = Diorequest(); //单例对象

//dio请求工具发出请求返回的数据 存在Response<dynamic>，需要用Response<dynamic>.data取出
// 把所有的接口的data结构出来，拿到真正的数据，要判断业务状态码是否等于1，
