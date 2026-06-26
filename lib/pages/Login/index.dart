import 'package:flutter/material.dart';
import 'package:hm_shop_flutter/utils/Toastutils.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _phoneController = TextEditingController(); //账号控制器
  TextEditingController _codeController = TextEditingController(); //密码控制器

  // 用户账号widget
  Widget _buildPhoneTextField() {
    return TextFormField(
      //校验
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "手机号不能为空";
        }
        //校验手机号格式-正则 1开头 11位
        if (!RegExp(r"^1[3-9]\d{9}$").hasMatch(value)) {
          return "手机号格式不正确";
        }
        return null;
      },
      controller: _phoneController,
      decoration: InputDecoration(
        hintText: "请输入手机号",
        contentPadding: EdgeInsets.only(left: 20), //内容内边距
        fillColor: const Color.fromRGBO(243, 243, 243, 1),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // 密码账号widget
  Widget _buildCodeTextField() {
    return TextFormField(
      //校验
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "账号不能为空";
        }
        // 6-16位的数字、字母或_
        if (!RegExp(r"^[0-9A-Za-z_]{6,16}$").hasMatch(value)) {
          return "请输入6-16位的字母数字或下划线";
        }
        return null;
      },
      controller: _codeController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: "请输入密码",
        contentPadding: EdgeInsets.only(left: 20), //内容内边距
        fillColor: const Color.fromRGBO(243, 243, 243, 1),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  //登录按钮
  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          //登录逻辑。
          //表单校验
          if (_key.currentState!.validate()) {
            //手机号和密码都有效
            //进行勾选框的判断
            if (_isChecked) {
              //校验通过
            } else {
              //提示
              ToastUtils.showToast(context, '请勾选用户协议');
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(25),
          ),
        ),
        child: Text("登录", style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
    );
  }

  bool _isChecked = false;
  //勾选Widget
  Widget _buildCheckbox() {
    return Row(
      children: [
        //设置勾选为圆角
        Checkbox(
          value: _isChecked,
          activeColor: Colors.black,
          checkColor: Colors.white,
          onChanged: (bool? value) {
            _isChecked = value ?? false;
            setState(() {});
          },
          //设置形状
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10),
          ),
          //设置边框
          side: BorderSide(color: Colors.grey, width: 1.5),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "查看并同意"),
              TextSpan(
                text: "《隐私条款》",
                style: TextStyle(color: Colors.blue),
              ),
              TextSpan(text: "和"),
              TextSpan(
                text: "《用户协议》",
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //头部Widget
  Widget _buildHeader() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsetsGeometry.only(left: 10),
          child: Text(
            "账号密码登录",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  //控制校验逻辑，GlobalKey绑定form组件可以调用validate方法
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('惠多美登录', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: _key,
        child: Container(
          padding: EdgeInsets.all(30),
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 20),
              _buildHeader(),
              SizedBox(height: 20),
              _buildPhoneTextField(),
              SizedBox(height: 20),
              _buildCodeTextField(),
              SizedBox(height: 20),
              _buildCheckbox(),
              SizedBox(height: 20),
              _buildLoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}
