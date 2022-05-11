import 'package:flutter/material.dart';
import 'package:ploy_transport/states/create_account.dart';
import 'package:ploy_transport/states/register.dart';
import 'package:ploy_transport/utility/my_constant.dart';
import 'package:ploy_transport/widgets/show_button.dart';
import 'package:ploy_transport/widgets/show_form.dart';
import 'package:ploy_transport/widgets/show_image.dart';
import 'package:ploy_transport/widgets/show_textbutton.dart';
import 'package:ploy_transport/widgets/showtext.dart';

class Authen extends StatelessWidget {
  const Authen({
    Key? key,
  }) : super(key: key);

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  newLogo(constraints),
                  newText(),
                  newEmail(),
                  newPassword(),
                  newButton(), //ปุ่ม
                  newCreateAccount(context: context)
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

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
                MaterialPageRoute( //back กลับไปหน้า login
                  builder: (context) => Register(),
                ));
          },
        )
      ],
    );
  }

  ShowButton newButton() => ShowButton(
        label: 'Login',
        pressFunc: () {},
      );

  ShowForm newPassword() {
    return ShowForm(
      label: 'Password',
      iconData: Icons.lock,
      obsecu: true,
      changeFunc: (String string) {},
    );
  }

  ShowForm newEmail() {
    return ShowForm(
      label: 'Email',
      iconData: Icons.email,
      changeFunc: (String string) {},
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
}
