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

// 特惠推荐--返回的是对象
Future<SpecoalRecommendResult> getProductListAPI() async{
  //返回请求
 return SpecoalRecommendResult.fromJSON(
   await dioRequest.get(HttpConstants.PRODUCT_LIST)
 );
}

// 热榜推荐
Future<SpecoalRecommendResult> getInVogueListAPI() async {
  // 返回请求
  return SpecoalRecommendResult.fromJSON(
    await dioRequest.get(HttpConstants.IN_VOGUE_LIST),
  );
}

// 一站式推荐
Future<SpecoalRecommendResult> getOneStopListAPI() async {
  // 返回请求
  return SpecoalRecommendResult.fromJSON(
    await dioRequest.get(HttpConstants.ONE_STOP_LIST),
  );
}

// 推荐列表
Future<List<GoodDetailItem>> getRecommendListAPI(
  Map<String, dynamic> params, // limit传递参数
) async {
  // 返回请求
  return ((await dioRequest.get(HttpConstants.RECOMMEND_LIST, params: params))
          as List)
      .map((item) {
        return GoodDetailItem.formJSON(item as Map<String, dynamic>);
      })
      .toList();
}
