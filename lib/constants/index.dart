// 全局常量
class GlobalConstants{
  // 静态属性，可以直接GlobalConstants.BASE_URL取出，否则还需要GlobalConstants().BASE_URL才能取出
  //都是常量，不可变，用const修饰，const是编译时确定，finial是运行时确定
  static const String BASE_URL = "https://meikou-api.itheima.net"; //基础地址
  static const int TIME_OUT = 10; //超时时间
  static const String SUCCESS_CODE = '1'; //成功状态
}

// 请求地址接口的常量
class HttpConstants{
  static const String BANNER_LIST="/home/banner";
  static const String CATEGORY_LIST="/home/category/head";//分类列表
  
}