import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ploy_transport/models/authen.dart';
import 'package:ploy_transport/states/create_account.dart';
import 'package:ploy_transport/states/register.dart';
import 'package:ploy_transport/utility/my_constant.dart';
import 'package:ploy_transport/utility/my_dialog.dart';
import 'package:ploy_transport/widgets/show_button.dart';
import 'package:ploy_transport/widgets/show_form.dart';
import 'package:ploy_transport/widgets/show_image.dart';
import 'package:ploy_transport/widgets/show_textbutton.dart';
import 'package:ploy_transport/widgets/showtext.dart';

class Authen extends StatefulWidget {
  const Authen({
    Key? key,
  }) : super(key: key);

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  String? rollerId, userName, passWord;

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
      textInputType: TextInputType.text,
      label: 'Username',
      iconData: Icons.email,
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
        })
        .catchError((onError) {
           print('OnError Authen ==> ${onError.toString()}');
        });
  }
}
