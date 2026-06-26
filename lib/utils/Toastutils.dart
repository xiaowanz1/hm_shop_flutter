
import 'package:flutter/material.dart';

class ToastUtils {
  static void showToast(BuildContext context,String? mag){
     ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      width: 120,
      behavior:SnackBarBehavior.floating,
      duration: Duration(seconds: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(40),
      ),
      content:Text(mag ?? "加载成功",textAlign: TextAlign.center,)
      )
      );
  }
}
