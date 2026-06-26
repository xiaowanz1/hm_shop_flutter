
//类型声明，用class更明确，每一个轮播图的具体类型
class BannerItem {
  String id;
  String imgUrl;
  BannerItem({required this.id,required this.imgUrl}); //可选命名参数语法糖

  // 扩展一个工程函数，一般用factory来声明，用来创建实例对象
  factory BannerItem.formJSON(Map<String,dynamic> json){
    //必须返回一个BannerItem对象
    return BannerItem(
      id:json["id"] ?? "",
      imgUrl: json["imgUrl"] ?? "" );

  }
}

//flutter必须强制转化，没有隐士转化


// 分类列表
class CategoryItem {
  String id;
  String name;
  String picture;
  List<CategoryItem>? children;
  CategoryItem({
    required this.id,
    required this.name,
    required this.picture,
    this.children
    });
    //扩展一个工厂函数
    factory CategoryItem.fromJSON(Map<String,dynamic> json){
      //必须返回一个CategoryItem对象
      return CategoryItem(
        id:json["id"] ?? "",
        name: json["name"] ?? "",
        picture: json["picture"] ?? "",
       children: json["children"] == null ?
       null : 
       (json["children"] as List).map((item)=>
         CategoryItem.fromJSON(item)
       ).toList()
       );
    }
}