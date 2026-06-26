import 'package:hm_shop_flutter/constants/index.dart';
import 'package:hm_shop_flutter/utils/DioRequest.dart';
import 'package:hm_shop_flutter/viewmodels/home.dart';

//猜你喜欢 有参数
// page:1 pageSize:10
Future<GoodsDetailsItems> getGuessListAPI(Map<String, dynamic> params) async {
  return GoodsDetailsItems.fromJSON(
    await dioRequest.get(HttpConstants.GUESS_LIST, params: params),
  );
}
