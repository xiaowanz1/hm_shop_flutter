import 'package:hm_shop_flutter/constants/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tokenmanager {
  String _token = '';

  //初始化token
  //返回对应的持久化对象的对象实例
  Future<SharedPreferences> _getInstance() {
    return SharedPreferences.getInstance();
  }

  init() async {
    final prefs = await _getInstance();
    _token = prefs.getString(GlobalConstants.TOKEN_KEY) ?? "";
  }

  //设置token
  Future<void> setToken(String val) async {
    //1.获取持久化对象实例
    final prefs = await _getInstance();
    prefs.setString(GlobalConstants.TOKEN_KEY, val); //将token写入持久化 磁盘
    _token = val;
  }

  //获取token, 希望是同步方法，否则在dio注入token时会有类型错误
  String getToken() {
    return _token;
  }

  //删除token
  Future<void> removeToken() async {
    final prefs = await _getInstance();
    prefs.remove(GlobalConstants.TOKEN_KEY); //删除磁盘上的
    _token = ''; // 删除内存中的
  }
}

final tokenManager = Tokenmanager();
