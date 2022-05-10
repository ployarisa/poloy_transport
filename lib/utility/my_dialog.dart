// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:ploy_transport/utility/my_constant.dart';
import 'package:ploy_transport/widgets/show_image.dart';
import 'package:ploy_transport/widgets/show_listtitle.dart';
import 'package:ploy_transport/widgets/show_textbutton.dart';
import 'package:ploy_transport/widgets/showtext.dart';

class MyDialog {
  final BuildContext context;
  MyDialog({
    required this.context,
  });

  Future<void> twoWayDialog({
    required String title,
    required String subTitle,
    required String label1,
    required String label2,
    required Function() pressFunc1,
    required Function() pressFunc2,
  }) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: ShowListTile(
          title: title,
          subTitle: subTitle,
          path: 'images/avatar.png',
        ),
        actions: [
          ShowTextButton(
            label: label1,
            pressFuvc: pressFunc1,
          ),
          ShowTextButton(
            label: label2,
            pressFuvc: pressFunc2,
          ),
          ShowTextButton(
            label: 'Cancel',
            pressFuvc: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> normalDialog(
      {required String title, required String subTitle}) async {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: ShowListTile(
                  title: title, subTitle: subTitle, path: 'images/logo.png'),
                  actions: [ShowTextButton(label: 'OK', pressFuvc: (){
                    Navigator.pop(context);
                  })],
            ));
  }
}
