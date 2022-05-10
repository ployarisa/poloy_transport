// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:ploy_transport/utility/my_constant.dart';
import 'package:ploy_transport/widgets/showtext.dart';

class ShowTextButton extends StatelessWidget {
  final String label;
  final Function() pressFuvc;
  const ShowTextButton({
    Key? key,
    required this.label,
    required this.pressFuvc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: pressFuvc,
        child: ShowText(
          label: label,
          textStyle: MyConstant().h3Activestyle(),
        ));
  }
}
