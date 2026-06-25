import 'package:flutter/material.dart';

class HmMoreList extends StatefulWidget {
  HmMoreList({Key? key}) : super(key: key);

  @override
  _HmMoreListState createState() => _HmMoreListState();
}

class _HmMoreListState extends State<HmMoreList> {
  @override
  Widget build(BuildContext context) {
    //必须是sliver家族的组件
    return SliverGrid.builder(
      gridDelegate:  //网格是2列
      SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        ), 
      itemBuilder: (BuildContext contex,int index){
        return Padding(padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
        child:   Container(
          child: Text('商品',style: TextStyle(color:Colors.white ),),
          color: Colors.blue,
          alignment: Alignment.center,
        ));
      
    });
  }
}