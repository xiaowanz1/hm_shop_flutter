import 'package:flutter/material.dart';
import 'package:hm_shop_flutter/viewmodels/home.dart';

class HmCategory extends StatefulWidget {
  // 分类列表
  final List<CategoryItem> _categoryList;
  HmCategory({Key? key, required this._categoryList}) : super(key: key);

  @override
  _HmCategoryState createState() => _HmCategoryState();
}

class _HmCategoryState extends State<HmCategory> {
  @override
  Widget build(BuildContext context) {
    // 返回一个横向滚动的组件，需要先设置高度
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget._categoryList.length,
        itemBuilder:(BuildContext context,int index)  {
          //根据数据渲染的不同的分类选项
          final category = widget._categoryList[index];
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: 80,
            height: 100,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 231, 232, 234),
              borderRadius: BorderRadius.circular(40),
            ),
           
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(category.picture,fit: BoxFit.cover,width: 40,height: 40,),
                Text(category.name,style: TextStyle(color:Colors.black ),),
              ],
            ),
          );
        },
      ),
    );
  }
}