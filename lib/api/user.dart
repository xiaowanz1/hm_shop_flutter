// 登录接口APi

import 'package:hm_shop_flutter/constants/index.dart';
import 'package:hm_shop_flutter/utils/DioRequest.dart';
import 'package:hm_shop_flutter/viewmodels/user.dart';

Future<UserInfo> loginAPI(Map<String, dynamic> data) async {
  return UserInfo.fromJSON(
    await dioRequest.post(HttpConstants.LOGIN, data: data),
  );
}

// 获取用户信息 不需要传参，可以在dio请求中注入token
Future<UserInfo> getUserInfoAPI() async {
  return UserInfo.fromJSON(await dioRequest.get(HttpConstants.USER_PROFILE));
}
