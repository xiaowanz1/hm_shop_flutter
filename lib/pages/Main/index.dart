import 'package:flutter/material.dart';
import 'package:hm_shop_flutter/pages/Cart/index.dart';
import 'package:hm_shop_flutter/pages/Category/index.dart';
import 'package:hm_shop_flutter/pages/Home/index.dart';
import 'package:hm_shop_flutter/pages/My/index.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //定义数据 根据数据进行渲染4个导航
  //一般应用程序的导航是固定不变的
  final List<Map<String,String>> _tableList = [
    {
      "icon":"lib/assets/ic_public_home_normal.png", //正常显示的图标
      "active_icon":"lib/assets/ic_public_home_active.png",//激活状态显示的图片
      "text":'首页'
    },
     {
      "icon":"lib/assets/ic_public_pro_normal.png", //正常显示的图标
      "active_icon":"lib/assets/ic_public_pro_active.png",//激活状态显示的图片
      "text":'分类'
    },
     {
      "icon":"lib/assets/ic_public_cart_normal.png", //正常显示的图标
      "active_icon":"lib/assets/ic_public_cart_active.png",//激活状态显示的图片
      "text":'购物车'
    },
     {
      "icon":"lib/assets/ic_public_my_normal.png", //正常显示的图标
      "active_icon":"lib/assets/ic_public_my_active.png",//激活状态显示的图片
      "text":'我的'
    },
  ];

  int _currentIndex = 0;

// 返回底部渲染的四个分类
  List<BottomNavigationBarItem> _getTabBarWidget(){
    return List.generate(_tableList.length, (int index){
      return BottomNavigationBarItem(
        icon: Image.asset(_tableList[index]["icon"]!, width: 30,height: 30),
        activeIcon:Image.asset(_tableList[index]["active_icon"]!, width: 30,height: 30),
        label: _tableList[index]["text"],
      );
    });
  }

  List<Widget> _getChildren(){
    return [
      HomeView(),
      CartView(),
      CategoryView(),
      MineView()
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //SafeArea避开安全区组件 适配
      body: SafeArea(child: IndexedStack(
        index: _currentIndex,
        children: _getChildren(),
      )),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        items: _getTabBarWidget(),
        onTap: (int index) {
          // index 就是当前点击的索引
          _currentIndex = index;
          setState(() {});
        },
        currentIndex : _currentIndex,
        ),
    );
  }
}