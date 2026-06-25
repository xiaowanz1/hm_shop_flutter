import 'package:flutter/material.dart';
import 'package:hm_shop_flutter/components/Home/HmCategory.dart';
import 'package:hm_shop_flutter/components/Home/HmHot.dart';
import 'package:hm_shop_flutter/components/Home/HmMoreList.dart';
import 'package:hm_shop_flutter/components/Home/HmSlider.dart';
import 'package:hm_shop_flutter/components/Home/HmSuggestion.dart';
import 'package:hm_shop_flutter/pages/Category/index.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //获取滚动容器内容
  List<Widget> _getScrollChildren(){
    return [
      //包裹普通widget的sliver家族的组件
      SliverToBoxAdapter(child: HmSlider(),), //轮播图组件
      //间距组件 
      SliverToBoxAdapter(child: SizedBox(height: 10,),),

      // SliverGrid SliverList只能纵向排列
       // ListView
      SliverToBoxAdapter(child: HmCategory(),),  // 分类组件，横向滑动
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
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollChildren(),); //sliver家族的内容
  }
}