import 'package:flutter/material.dart';
import 'package:hm_shop_flutter/viewmodels/home.dart';

class Hmsuggestion extends StatefulWidget {
  // 特惠推荐数据
  SpecoalRecommendResult specialRecommendResult;
  Hmsuggestion({Key? key,required this.specialRecommendResult}) : super(key: key);

  @override
  _HmsuggestionState createState() => _HmsuggestionState();
}

class _HmsuggestionState extends State<Hmsuggestion> {
  //取前3条数据
  List<GoodsItem> _getDisplayItems(){
    var subTypes = widget.specialRecommendResult.subTypes;
    if(subTypes.isEmpty) return []; //数据是空的
    return subTypes.first.goodsItems.items.take(3).toList();
  }

  //顶部文字
  Widget _buildHeader(){
    return Row(children: [
      Text("特惠推荐",style: TextStyle(
        color: const Color.fromARGB(255, 120, 25, 19),
        fontSize: 18,
        fontWeight: FontWeight.w700,
        )),
        SizedBox(width: 10,),
        Text("精选省攻略",style: TextStyle(
           color: const Color.fromARGB(255, 120, 25, 19),
           fontSize: 12
        ),)
    ],);
  }

//左侧固定图片
 Widget _buildLeft(){
  return Container(
    width: 100,
    height: 140,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      image: DecorationImage(
        image: AssetImage("lib/assets/home_cmd_inner.png"),
        fit: BoxFit.cover),
      
    ),
  );
 }
//获取列表数据并渲染
 List<Widget> _getChildrenList(){
  List<GoodsItem> list = _getDisplayItems();//取到前3条数据
  print("商品列表长度：${list.length}");
  if(list.isEmpty){
    return [
      Container(
      height: 100,
      width: 140,
      color: Colors.amber,
      alignment: Alignment.center,
      child: Text('暂无商品'),
    )
    ];
  }
  return List.generate(list.length, (int index){
    return Column(
      children: [
        // ClipRRect 可以包裹子元素，裁剪图片设置圆角
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            errorBuilder: (context, error, stackTrace) {
              //如果图片加载失败，返回一个新的部件（本地图片）替换原有图片
              return Image.asset('lib/assets/home_cmd_inner.png',
              width: 100,
              height: 140,
              fit:BoxFit.cover
              );

            },
            list[index].picture,width: 100,height: 140,fit: BoxFit.cover,),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text("￥${list[index].price}", style: TextStyle(color: Colors.white),),)
      ],
    );
  });
 }

  //完成渲染
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 10),
    child: Container(
      padding: EdgeInsets.all(12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage("lib/assets/home_cmd_sm.png"),fit:BoxFit.cover,),
      borderRadius: BorderRadius.circular(12),
      
      ),
       child:Column(
        children: [
          //顶部文字
          _buildHeader(),
          SizedBox(height: 10,),
          Row(
            children: [
              _buildLeft(),
              Expanded(child: 
              SingleChildScrollView(
                scrollDirection:Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                children: _getChildrenList(),
              ),
              )
              ) //左侧图片
            ],
          )

        ],
       )
    ));
    
  }
}