import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_1800/pages/user/loginView.dart';
import 'package:flutter_1800/service/firestore_service.dart';
import 'package:flutter_1800/tools/AppUtil.dart';
import 'package:flutter_1800/tools/config.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RegisterViewPage extends StatefulWidget {
  const RegisterViewPage({Key? key}) : super(key: key);

  @override
  _RegisterViewPageState createState() => _RegisterViewPageState();
}

class _RegisterViewPageState extends State<RegisterViewPage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  //表单状态
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    super.dispose();
  }
  //check the email format
  bool isEmail(String input) {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(input);
  }

  void submit() {
    String email = _emailController.text;

    if (_userNameController.text == "") {
      EasyLoading.showInfo("Please input user");
      return;
    }

    if (_passWordController.text == "") {
      EasyLoading.showInfo("Please input password");
      return;
    }
    if (email == "") {
      EasyLoading.showInfo("Please input email  ");
      return;
    }
    if (isEmail(email) == false) {
      EasyLoading.showInfo("Please input right email format");
      return;
    }

    FirestoreService.register(
            _userNameController.text, email, _passWordController.text)
        .then((value) {
      // ApiServic
      EasyLoading.showSuccess("Register Success");
      AppUtil.getTo(const LoginViewPage());
    }).catchError((e) {});
  }

  void registerHandler() {
    AppUtil.getTo(const RegisterViewPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: AppConfig.main,
          foregroundColor: Colors.white,
          leading: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
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
                "Register",
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
                "Hello,Welcome Register",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 50,
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
                        "User Name",
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
                            hintStyle: TextStyle(color: Color(0xffaaaaaa)),
                            hintText: "Input User Name",
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
                        "Email",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                          child: TextFormField(
                        cursorColor: Colors.black,
                        controller: _emailController,
                        //设置键盘类型
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            hintStyle: TextStyle(color: Color(0xffaaaaaa)),
                            hintText: "Input Email",
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
                            hintStyle: TextStyle(color: Color(0xffaaaaaa)),
                            hintText: "Input Password",
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
                  child: const Text("Register"),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(const StadiumBorder()),
                  ),
                  onPressed: submit),
            ),
          ],
        ),
      ),
    );
  }
}
