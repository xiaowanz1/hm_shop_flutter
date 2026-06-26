//需要共享的对象，有一些共享的属性，属性需要响应式更新
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:hm_shop_flutter/viewmodels/user.dart';

class Usercontroller extends GetxController {
  var user = UserInfo.fromJSON({}).obs; //user对象被监听了 observe
  //更新user的方法，  想要取值的话 需要user.value
  updateUserInfo(UserInfo newUser) {
    user.value = newUser;
  }
}
