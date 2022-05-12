// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ploy_transport/models/response_false_model.dart';
import 'package:ploy_transport/models/response_true_model.dart';
import 'package:ploy_transport/models/user_model.dart';
import 'package:ploy_transport/utility/my_constant.dart';
import 'package:ploy_transport/utility/my_dialog.dart';
import 'package:ploy_transport/widgets/show_button.dart';
import 'package:ploy_transport/widgets/show_form.dart';
import 'package:ploy_transport/widgets/show_form_phone.dart';
import 'package:ploy_transport/widgets/show_image.dart';
import 'package:ploy_transport/widgets/showtext.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? yearRegis, phoneNumber;
  String genType = 'M', inFriendId = '';

  @override
  void initState() {
    super.initState();
    findYear();
  } //ทำงานก่อนอันดับแรก

  void findYear() {
    DateTime dateTime = DateTime.now();
    int year = dateTime.year + 543;
    yearRegis = year.toString();
    // print('yearRegis = $yearRegis');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: ShowText(
          label: 'สมัครสมาชิก ผ่าน Server',
          textStyle: MyConstant().h2style(),
        ),
        elevation: 0,
        foregroundColor: MyConstant.dark,
        backgroundColor: Colors.white,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
        child: Container(
          decoration: MyConstant().planBox(),
          child: Center(
            child: LayoutBuilder(builder: (context, constanints) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 48,
                    ),
                    SizedBox(
                      width: constanints.maxHeight * 0.75,
                      child: ShowImage(
                        path: 'images/register.png',
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: ShowText(
                        label: 'Year = $yearRegis',
                        textStyle: MyConstant().h2style(),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: ShowText(
                        label: 'Gentype : $genType',
                        textStyle: MyConstant().h2style(),
                      ),
                    ),
                    ShowFormPhone(
                        label: 'Phone',
                        iconData: Icons.phone_android_outlined,
                        changeFunc: (String string) {
                          phoneNumber = string.trim();
                        }),
                    ShowButton(
                        label: 'register',
                        pressFunc: () {
                          if (phoneNumber?.isEmpty ?? true) {
                            MyDialog(context: context).normalDialog(
                                title: 'Phone ?',
                                subTitle: 'Please Fill Phone');
                          } else if (phoneNumber!.length != 10) {
                            MyDialog(context: context).normalDialog(
                                title: 'Phone 10 digi',
                                subTitle: 'Please fill Phone 10 digi');
                          } else if (phoneNumber!.contains(' ')) {
                            MyDialog(context: context).normalDialog(
                                title: 'มีช่องว่างแทรก',
                                subTitle: 'ห้ามมีช่องว่างแทรก');
                          } else {
                            processRegister();
                          }
                        }),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Future<void> processRegister() async {
    // print('phoneNumber ==> $phoneNumber');
    UserModel userModel = UserModel(
        year: yearRegis!,
        gentype: genType,
        phonenumber: phoneNumber!,
        infriendid: inFriendId);

    Map<String, dynamic> map = userModel.toMap();
    // print('map : $map');

    await Dio()
        .post(
      MyConstant.pathRegister,
      data: map,
    )
        .then((value) {
      // print('Success Register value ==> $value');

      ResponseFalseModel responseFalseModel =
          ResponseFalseModel.fromMap(value.data);

      // print('responseFalseModel ==> ${responseFalseModel.toMap()}');

      if (responseFalseModel.ResponseStatus == 'Failed') {
        MyDialog(context: context).normalDialog(
            title: 'Cannot Register',
            subTitle: responseFalseModel.ResponseMessages);
      } else {
        //Register success
        print('Register Success value ==> $value');
        ResponseTrueModel responseTrueModel =
            ResponseTrueModel.fromJson(value.data);

        print('responsTrueModel ===> ${responseTrueModel.toJson()}');

        MyDialog(context: context).normalDialog(
            title: 'Your Login',
            subTitle: 'โปรดเก็บค่านี้ไว้ Login',
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ShowText(
                    label:
                        'rollerid ==> ${responseTrueModel.responseData![0].rollerid}'),
                ShowText(
                    label:
                        'username ==> ${responseTrueModel.responseData![0].username}'),
                ShowText(
                    label:
                        'password ==> ${responseTrueModel.responseData![0].password}'),
              ],
            ),
            pressFunc: () {
              Navigator.pop(context);
              Navigator.pop(context);
            });
        // MyDialog(context: context)

      }
    }).catchError((onError) {
      print('onError ==> ${onError.toString()}');
    });
  }
}
