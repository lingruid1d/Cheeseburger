import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_1800/pages/home.dart';
import 'package:flutter_1800/pages/user/registerView.dart';
import 'package:flutter_1800/service/firestore_service.dart';
import 'package:flutter_1800/tools/AppUtil.dart';
import 'package:flutter_1800/tools/config.dart';
import 'package:flutter_1800/tools/storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginViewPage extends StatefulWidget {
  const LoginViewPage({Key? key}) : super(key: key);

  @override
  _LoginViewPageState createState() => _LoginViewPageState();
}

class _LoginViewPageState extends State<LoginViewPage> {
  //用户名输入框控制器，此控制器可以监听用户名输入框操作
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();

  //表单状态
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void loginHandler() {
    String email = _userNameController.text;
    String password = _passWordController.text;

    if (email == "") {
      EasyLoading.showInfo("Please Input Email");
      return;
    }

    if (password == "") {
      EasyLoading.showInfo("Please Input Password");
      return;
    }

    FirestoreService.login(email, password).then((value) {
      if (value != null) {
        StorageUtil.saveUser(value);
        // ApiServic
        EasyLoading.showSuccess("Login Success");
        AppUtil.getReplaceTo(const HomePage());
      } else {
        EasyLoading.showInfo("Email or password is wrong!");
      }
    }).catchError((e) {});
  }

  void registerHandler() {
    AppUtil.getTo(const RegisterViewPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light)),
      body: Container(
        decoration: const BoxDecoration(color: AppConfig.main),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).padding.top + 40,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  AppUtil.getPadding(), 0, AppUtil.getPadding(), 0),
              child: const Text(
                "Login",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  AppUtil.getPadding(), 20, AppUtil.getPadding(), 0),
              child: const Text(
                "Hello,Welcome Login",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 100,
            ),
            Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 5),
                    Row(children: [
                      const Text(
                        "Email",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                          child: TextFormField(
                        cursorColor: Colors.black,
                        controller: _userNameController,
                        //设置键盘类型
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            hintText: "Please Input Email",
                            hintStyle: TextStyle(color: Color(0xffaaaaaa)),
                            border: InputBorder.none),
                        onSaved: (username) {},
                      ))
                    ]),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      height: 1,
                      color: const Color(0xffeeeeee),
                    ),
                    const SizedBox(height: 5),
                    Row(children: [
                      const Text(
                        "Password",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                          child: TextFormField(
                        cursorColor: Colors.black,
                        controller: _passWordController,
                        obscureText: true,
                        //设置键盘类型
                        keyboardType: TextInputType.text,

                        decoration: const InputDecoration(
                            hintText: "Please Input Password",
                            hintStyle: TextStyle(color: Color(0xffaaaaaa)),
                            border: InputBorder.none),
                        onSaved: (username) {},
                      ))
                    ]),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      height: 1,
                      color: const Color(0xffeeeeee),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              margin: const EdgeInsets.all(40),
              child: ElevatedButton(
                  child: const Text("Login"),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(const StadiumBorder()),
                  ),
                  onPressed: loginHandler),
            ),
            Container(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    AppUtil.getTo(const RegisterViewPage());
                  },
                  child: const Text(
                    "No Account?Register",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
