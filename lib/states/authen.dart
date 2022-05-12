import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ploy_transport/models/authen_model.dart';
import 'package:ploy_transport/models/response_false_model.dart';
import 'package:ploy_transport/models/success_authen_model.dart';
import 'package:ploy_transport/states/create_account.dart';
import 'package:ploy_transport/states/register.dart';
import 'package:ploy_transport/utility/my_constant.dart';
import 'package:ploy_transport/utility/my_dialog.dart';
import 'package:ploy_transport/widgets/show_button.dart';
import 'package:ploy_transport/widgets/show_form.dart';
import 'package:ploy_transport/widgets/show_image.dart';
import 'package:ploy_transport/widgets/show_textbutton.dart';
import 'package:ploy_transport/widgets/showtext.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authen extends StatefulWidget {
  const Authen({
    Key? key,
  }) : super(key: key);

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  String? rollerId, userName, passWord;

  TextEditingController rollerIdControntroller = TextEditingController();
  TextEditingController userNameControntroller = TextEditingController();
  TextEditingController passwordControntroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    forTestAuthen();
  }

  void forTestAuthen() {
    rollerIdControntroller.text = '6510000038';
    userNameControntroller.text = '5453423242';
    passwordControntroller.text = '249192';

    rollerId = rollerIdControntroller.text;
    userName = userNameControntroller.text;
    passWord = passwordControntroller.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
          child: Container(
            decoration: MyConstant().imageBox(),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    newLogo(constraints),
                    newText(),
                    newRollerId(),
                    newUser(),
                    newPassword(),
                    newButton(), //ปุ่ม
                    newCreateAccount(context: context)
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  ShowForm newRollerId() => ShowForm(
      controller: rollerIdControntroller,
      textInputType: TextInputType.number,
      label: 'RollerID ',
      iconData: Icons.account_box,
      changeFunc: (String string) {
        rollerId = string.trim();
      });

  Row newCreateAccount({required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const ShowText(label: 'Non Account ?'),
        ShowTextButton(
          label: 'Create Account',
          pressFunc: () {
            //ย้ายหน้า
            Navigator.push(
                context,
                MaterialPageRoute(
                  //back กลับไปหน้า login
                  builder: (context) => Register(),
                ));
          },
        )
      ],
    );
  }

  ShowButton newButton() => ShowButton(
        label: 'Login',
        pressFunc: () {
          if ((rollerId?.isEmpty ?? true) ||
              (userName?.isEmpty ?? true) ||
              (passWord?.isEmpty ?? true)) {
            MyDialog(context: context).normalDialog(
                title: 'Have Space', subTitle: 'Please Fill Ever Blank');
          } else {
            processCheckAuthen();
          }
        },
      );

  ShowForm newPassword() {
    return ShowForm(
      controller: passwordControntroller,
      label: 'Password',
      iconData: Icons.lock,
      obsecu: true,
      changeFunc: (String string) {
        passWord = string.trim();
      },
    );
  }

  ShowForm newUser() {
    return ShowForm(
      controller: userNameControntroller,
      textInputType: TextInputType.text,
      label: 'Username',
      iconData: Icons.person,
      changeFunc: (String string) {
        userName = string.trim();
      },
    );
  }

  ShowText newText() {
    return ShowText(
      label: 'Login ',
      textStyle: MyConstant().h1style(),
    );
  }

  SizedBox newLogo(BoxConstraints constraints) {
    return SizedBox(
      width: constraints.maxWidth * 0.4,
      child: const ShowImage(),
    );
  }

  Future<void> processCheckAuthen() async {
    AuthenModel authenModel = AuthenModel(
        rollerid: rollerId!, username: userName!, password: passWord!);
    await Dio()
        .post(MyConstant.pathAuthen, data: authenModel.toMap())
        .then((value) {
      print('OnError Authen ==> $value');

      ResponseFalseModel responseFalseModel =
          ResponseFalseModel.fromMap(value.data);

      print('ResponseStatus ==> ${responseFalseModel.ResponseStatus}');

      if (responseFalseModel.ResponseStatus == 'Failed') {
        MyDialog(context: context).normalDialog(
            title: 'Login False',
            subTitle: responseFalseModel.ResponseMessages);
      } else {
        SuccessAuthenModel successAuthenModel =
            SuccessAuthenModel.fromJson(value.data);
        processSaveUser(successAuthenModel: successAuthenModel);
      }
    }).catchError((onError) {
      print('OnError Authen ==> ${onError.toString()}');
    });
  }

  Future<void> processSaveUser(
      {required SuccessAuthenModel successAuthenModel}) async {
    String token = successAuthenModel.responseData![0].token.toString();
    print('token ===> $token');

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(MyConstant.keyRollerId, rollerId!);
    preferences.setString(MyConstant.keyUsername, userName!);
    preferences.setString(MyConstant.keyPassword, passWord!);
    preferences.setString(MyConstant.keyToken, token);

    Navigator.pushNamedAndRemoveUntil(context, '/myService', (route) => false);
  }
}
