import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop_flutter/viewmodels/home.dart';

class HmSlider extends StatefulWidget {
  final List<BannerItem> _bannerList;
  HmSlider({Key? key, required this._bannerList}) : super(key: key);

  @override
  _HmSliderState createState() => _HmSliderState();
}

class _HmSliderState extends State<HmSlider> {
  Widget _getSlider(){
    //获取屏幕宽度的方法
    final double screenWidth=  MediaQuery.of(context).size.width;//屏幕宽度
    //返回轮播图插件
    //根据数据渲染的不同的轮播选项
    return CarouselSlider(
      items: 
      List.generate(widget._bannerList.length, 
    (int index){
      return Image.network(
        widget._bannerList[index].imgUrl,
        fit: BoxFit.cover,
        width: screenWidth,
        );
    }), 
    options: CarouselOptions(
      height: 300,
      autoPlayInterval:Duration(seconds:5),
      viewportFraction: 1,
      autoPlay: true //自动播放
    ));
  }

  @override
  Widget build(BuildContext context) {
    //Stack -> 轮播图 搜索框 指示灯导航
    return Stack(
      children: [_getSlider()],
    );

    // return Container(
    //   color: Colors.blue,
    //   alignment: Alignment.center,
    //   height: 300,
    //    child: Text("轮播图",style: TextStyle(color: Colors.white,fontSize: 20),),
    // );
  }
}