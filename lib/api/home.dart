// 封装一个api，目的是返回业务侧要的数据

import 'package:hm_shop_flutter/constants/index.dart';
import 'package:hm_shop_flutter/utils/DioRequest.dart';
import 'package:hm_shop_flutter/viewmodels/home.dart';

Future<List<BannerItem>> getBannerListAPI() async{
  //返回请求
 final tt =  (await dioRequest.get(HttpConstants.BANNER_LIST) as List).map((item){
    return BannerItem.formJSON(item);
  }).toList();
  return tt;
}

// 分类列表
Future<List<CategoryItem>> getCategoryListAPI() async{
  //返回请求
 final tt =  (await dioRequest.get(HttpConstants.CATEGORY_LIST) as List).map((item){
    return CategoryItem.fromJSON(item);
  }).toList();
  return tt;
}
