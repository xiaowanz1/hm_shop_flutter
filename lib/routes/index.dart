// 管理路由
import 'package:flutter/material.dart';
import 'package:hm_shop_flutter/pages/Login/index.dart';
import 'package:hm_shop_flutter/pages/Main/index.dart';

// 返回 getRootWidget给App根组件用
Widget getRootWidget(){
  return MaterialApp(
    initialRoute: '/',
    //命名路由
    routes: getRootRoutes(),
  );
  
  
}

//返回该App的路由配置
Map<String, Widget Function(BuildContext)> getRootRoutes(){
  return {
    "/":(context)=>MainPage(), //主页
    "/login":(context)=>LoginPage() //登录页
  };
}