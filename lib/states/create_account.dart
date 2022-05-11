import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ploy_transport/utility/my_constant.dart';
import 'package:ploy_transport/utility/my_dialog.dart';
import 'package:ploy_transport/widgets/show_button.dart';
import 'package:ploy_transport/widgets/show_form.dart';
import 'package:ploy_transport/widgets/show_icon_button.dart';
import 'package:ploy_transport/widgets/show_image.dart';
import 'package:ploy_transport/widgets/showtext.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  var typeUsers = MyConstant.typeUsers;
  String? typeUser;
  //ประกาศตัวแปร Global
  File? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: ShowText(
          label: 'Create New Account',
          textStyle: MyConstant().h2style(),
        ),
        elevation: 3,
        foregroundColor: MyConstant.dark,
        backgroundColor: Colors.white,
      ),
      
      body: ListView(
        children: [
          newCenter(widget: newAvatar()),
          newCenter(
            widget: ShowForm(
              label: ' Name ',
              iconData: Icons.person,
              changeFunc: (String string) {},
            ),
          ),
          newCenter(
            widget: newTypeUser(),
          ),
          newCenter(
            widget: ShowForm(
              label: 'Emaill',
              iconData: Icons.email_outlined,
              changeFunc: (String string) {},
            ),
          ),
          newCenter(
            widget: ShowForm(
              label: 'Password',
              iconData: Icons.lock_clock_outlined,
              changeFunc: (String string) {},
              obsecu: true,
            ),
          ),
          newCenter(
            widget: ShowForm(
              label: 'Re-Password',
              iconData: Icons.lock,
              changeFunc: (String string) {},
              obsecu: true,
            ),
          ),
          newCenter(
            widget: ShowButton(
              label: 'Create New Account',
              pressFunc: () {
                if (file == null) {
                  MyDialog(context: context).normalDialog(
                      title: 'Non avatar ?', subTitle: 'Please take Avatar');
                }
              },
            ),
          )
        ],
      ),
    );
  }

//dropdown
  Widget newTypeUser() {
    return Container(
      padding: const EdgeInsets.only(left: 8),
      margin: const EdgeInsets.only(top: 16),
      decoration: MyConstant().curveBorderBox(),
      width: 250,
      height: 50,
      child: DropdownButton<dynamic>(
          hint: const ShowText(label: 'Please Choose TypeUser'),
          value: typeUser,
          items: typeUsers
              .map(
                (e) => DropdownMenuItem(
                  child: ShowText(label: e),
                  value: e,
                ),
              )
              .toList(),
          onChanged: (value) {
            setState(() {
              typeUser = value.toString();
            });
          }),
    );
  }

  Widget newAvatar() {
    return Container(
      margin: const EdgeInsets.only(top: 36, bottom: 16),
      width: 250,
      height: 250,
      child: Stack(
        children: [
          file == null
              ? const ShowImage(
                  path: 'images/avatar.png',
                )
              : CircleAvatar(
                  radius: 200,
                  backgroundImage: FileImage(file!),
                ),
          Positioned(
            right: 40,
            bottom: 2,
            child: showIconButton(
              size: 40,
              iconData: Icons.add_a_photo,
              pressFunc: () {
                MyDialog(context: context).twoWayDialog(
                    title: 'Choose Avatar ?',
                    subTitle: 'Please tap camera or Gallery',
                    label1: 'Camera',
                    pressFunc1: () {
                      Navigator.pop(context);
                      processTakePhoto(source: ImageSource.camera);
                    },
                    label2: 'Gallery',
                    pressFunc2: () {
                      Navigator.pop(context);
                      processTakePhoto(source: ImageSource.gallery);
                    });
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> processTakePhoto({required ImageSource source}) async {
    var result = await ImagePicker()
        .pickImage(source: source, maxWidth: 800, maxHeight: 800);

    if (result != null) {
      file = File(result.path);
      setState(() {});
    }
  }

  Row newCenter({required Widget widget}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget,
      ],
    );
  }
}
