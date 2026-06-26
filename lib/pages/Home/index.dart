import 'package:flutter/material.dart';
import 'package:hm_shop_flutter/api/home.dart';
import 'package:hm_shop_flutter/components/Home/HmCategory.dart';
import 'package:hm_shop_flutter/components/Home/HmHot.dart';
import 'package:hm_shop_flutter/components/Home/HmMoreList.dart';
import 'package:hm_shop_flutter/components/Home/HmSlider.dart';
import 'package:hm_shop_flutter/components/Home/HmSuggestion.dart';
import 'package:hm_shop_flutter/pages/Category/index.dart';
import 'package:hm_shop_flutter/utils/Toastutils.dart';
import 'package:hm_shop_flutter/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // 分类列表
  List<CategoryItem> _categoryList = [];
  // 特惠推荐
  SpecoalRecommendResult _specialRecommendResult = SpecoalRecommendResult(
    id:"",
    title:"",
    subTypes: [],
  );
  // 热榜推荐
  SpecoalRecommendResult _inVogueResult = SpecoalRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  // 一站式推荐
  SpecoalRecommendResult _oneStopResult = SpecoalRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
// 推荐列表
  List<GoodDetailItem> _recommendList = [];

  //页码
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;//是否还有下一页


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
      SliverToBoxAdapter(child: Hmsuggestion(specialRecommendResult:_specialRecommendResult),), //推荐
      //间距组件 
      SliverToBoxAdapter(child: SizedBox(height: 10,),),

      //爆款推荐
      SliverToBoxAdapter(
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
        child:Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
                child: HmHot(result: _inVogueResult, type: "hot"),
              ),
              SizedBox(width: 10),
              Expanded(
                child: HmHot(result: _oneStopResult, type: "step"),
              ),
          ],
      ))),

     
      //间距组件 
      SliverToBoxAdapter(child: SizedBox(height: 10,),),
      // 无限列表
      HmMoreList(recommendList: _recommendList), // 无限滚动列表
    ];
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _registerEvent();
    Future.microtask((){
      _key.currentState?.show();}
    );
  }
//initState > build > 下拉刷新组件 > 才可以操作
 // Future.micoTask微任务


//监听滚动到底部的事件
void _registerEvent(){
_controller.addListener((){
  //已经滚动的距离_controller.position.pixels
  //滚动到底部的最大距离_controller.position.maxScrollExtent
  if(_controller.position.pixels >= 
  _controller.position.maxScrollExtent - 50){
    //已经接近底部了，加载下一页数据
  _getRecommendList();
  }
});
}
  //获取轮播图数据
  Future<void> _getBannerList()async{
   _bannerList =  await getBannerListAPI();
   setState(() {});
  }
  //获取分类列表数据
  Future<void> _getCategoryList()async{
    _categoryList =  await getCategoryListAPI();
    setState(() {});
  }
  //获取特惠推荐数据
  Future<void> _getSpecialRecommendList()async{
    _specialRecommendResult =  await getProductListAPI();
    setState(() {});
  }
    // 获取热榜推荐列表
  Future<void> _getInVogueList() async {
    _inVogueResult = await getInVogueListAPI();
    setState(() {});
  }

  // 获取一站式推荐列表
  Future<void> _getOneStopList() async {
    _oneStopResult = await getOneStopListAPI();
    setState(() {});
  }
  // 获取推荐列表
  Future<void> _getRecommendList() async {
    if(_isLoading || !_hasMore){
      return;
    }
    _isLoading = true;//站住位置
     int requestLimit = _page * 8;
    _recommendList = await getRecommendListAPI({"limit": requestLimit});
    _isLoading  = false;//松开
        setState(() {});
    if(_recommendList.length < requestLimit){
      _hasMore = false;
      return;
    }
    _page++;
  }

Future<void> _onRefresh()async {
 //重置数据
 _page = 1;
 _isLoading = false;
 _hasMore = true;//是否还有下一页

  await _getBannerList();
   await _getCategoryList();
   await _getSpecialRecommendList();
   await _getInVogueList();
   await _getOneStopList();
   await _getRecommendList();
   //刷新数据成功
  ToastUtils.showToast(context, '刷新成功');
}

  final ScrollController _controller = ScrollController();
  //GlobalKey是一个方法可以创建一个key绑定到Widget部件上，来操作Widget部件
  final GlobalKey<RefreshIndicatorState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _key,
      //把函数绑定到事件上
      onRefresh:_onRefresh, 
      child: CustomScrollView(
      controller: _controller,
      slivers: _getScrollChildren(),)); //sliver家族的内容
  }
}