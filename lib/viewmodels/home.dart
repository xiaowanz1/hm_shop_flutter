
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

// GoodsItem --商品信息
class GoodsItem{
  String id;
  String name;
  String picture;
  double price;
  String desc;
  GoodsItem({
    required this.id,
    required this.name,
    required this.picture,
    required this.price,
    required this.desc
  });
  factory GoodsItem.fromJSON(Map<String,dynamic> json){
    //必须返回一个GoodsItem对象
    return GoodsItem(
      id:json["id"]?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
      picture: json["picture"]?.toString() ?? "",
      price: double.parse(json["price"]) ?? 0.0,
      desc: json["desc"]?.toString() ?? ""
    );
  }
}


//GoodsItems --商品分页信息
class GoodsItems {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<GoodsItem> items;
  GoodsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items
  });
  factory GoodsItems.fromJSON(Map<String,dynamic> json){
    //必须返回一个GoodsItems对象
    return GoodsItems(
      counts:json["counts"]?.toInt() ?? 0,
      pageSize: json["pageSize"]?.toInt() ?? 0,
      pages: json["pages"]?.toInt() ?? 0,
      page: json["page"]?.toInt() ?? 0,
      items: (json["items"] as List? ?? []).map((item)=>
        GoodsItem.fromJSON(item as Map<String,dynamic>)
      ).toList()
    );
  }
}



// 特惠推荐 -subType
class SubType {
  String id;
  String title;
  GoodsItems goodsItems;
  SubType({
    required this.id,
    required this.title,
    required this.goodsItems
  });
  factory SubType.fromJSON(Map<String,dynamic> json){
    //必须返回一个SubType对象
    return SubType(
      id:json["id"]?.toString() ?? "",
      title: json["title"]?.toString() ?? "",
      goodsItems: GoodsItems.fromJSON(json["goodsItems"] as Map<String,dynamic>)  
    );
  }
}


// 特惠推荐 -result
class SpecoalRecommendResult {
  String id;
  String title;
  List<SubType> subTypes;
  SpecoalRecommendResult({
    required this.id,
    required this.title,
    required this.subTypes
  });
  factory SpecoalRecommendResult.fromJSON(Map<String,dynamic> json){
    //必须返回一个SpecoalRecommendResult对象
    return SpecoalRecommendResult(
      id:json["id"]?.toString() ?? "",
      title: json["title"]?.toString() ?? "",
      subTypes: (json["subTypes"] as List? ?? []).map((item)=>
        SubType.fromJSON(item as Map<String,dynamic>)
      ).toList()
      );
  }
}