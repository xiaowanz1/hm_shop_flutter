import 'package:flutter/material.dart';
import 'package:hm_shop_flutter/api/home.dart';
import 'package:hm_shop_flutter/components/Home/HmCategory.dart';
import 'package:hm_shop_flutter/components/Home/HmHot.dart';
import 'package:hm_shop_flutter/components/Home/HmMoreList.dart';
import 'package:hm_shop_flutter/components/Home/HmSlider.dart';
import 'package:hm_shop_flutter/components/Home/HmSuggestion.dart';
import 'package:hm_shop_flutter/pages/Category/index.dart';
import 'package:hm_shop_flutter/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // 分类列表
  List<CategoryItem> _categoryList = [];

  //可以从接口获取数据
  //定义三条写死的轮播图数据传递给HmSlider()
  //https://imgcps.jd.com/ling-cubic/turing/focusChannelPcText/eea59e1eed5dddbbe733f96d3045873d/cr/s/q70.png
   List<BannerItem> _bannerList = [
  // BannerItem(
  //   id:"1",
  //   imgUrl: "https://assets.699pic.com/public/web/images/604/752/155.jpg!list1x.v2",
  //    ),
  //    BannerItem(
  //   id:"2",
  //   imgUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT72ddbr5aE9lwOMRcqblNFDeXYQoOUwCv8a-xqqCItplqlq-farDaZMAi9&s=10",
  //    ),
  //    BannerItem(
  //   id:"3",
  //   imgUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcStgDs03G44-DAzmyeiJJQ45KGifwllorGsgPAXrLoS9g&s",
  //    ),
  ];



  //获取滚动容器内容
  List<Widget> _getScrollChildren(){
    return [
      //包裹普通widget的sliver家族的组件
      SliverToBoxAdapter(child: HmSlider(bannerList:_bannerList),), //轮播图组件
      //间距组件 
      SliverToBoxAdapter(child: SizedBox(height: 10,),),

      // SliverGrid SliverList只能纵向排列
       // ListView
      SliverToBoxAdapter(child: HmCategory(categoryList:_categoryList),),  // 分类组件，横向滑动
//间距组件 
      SliverToBoxAdapter(child: SizedBox(height: 10,),),
      SliverToBoxAdapter(child: Hmsuggestion(),), //推荐
      //间距组件 
      SliverToBoxAdapter(child: SizedBox(height: 10,),),

      //爆款推荐
      SliverToBoxAdapter(
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
        child:Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(child: HmHot()),
          SizedBox(width: 10,), 
          Expanded(child: HmHot()),
          ],
      ))),

     
      //间距组件 
      SliverToBoxAdapter(child: SizedBox(height: 10,),),
      // 无限列表
      HmMoreList()
    ];
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getBannerList();
    _getCategoryList();
  }

  //获取轮播图数据
  void _getBannerList()async{
   _bannerList =  await getBannerListAPI();
   setState(() {});
  }
  //获取分类列表数据
  void _getCategoryList()async{
    _categoryList =  await getCategoryListAPI();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollChildren(),); //sliver家族的内容
  }
}