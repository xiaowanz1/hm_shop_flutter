import 'package:flutter/material.dart';

class ToastUtils {
  //阀门控制
  static bool showLoading = false;
  static void showToast(BuildContext context, String? mag) {
    if (showLoading) {
      return;
    }
    showLoading = true;
    //延后2秒后设置
    Future.delayed(Duration(seconds: 2), () {
      showLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 180,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(40),
        ),
        content: Text(mag ?? "加载成功", textAlign: TextAlign.center),
      ),
    );
  }
}
