// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:ploy_transport/utility/my_constant.dart';

class showIconButton extends StatelessWidget {
  final IconData iconData;
  final Function() pressFunc;
  final double? size;
  const showIconButton({
    Key? key,
    required this.iconData,
    required this.pressFunc,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: pressFunc,
      icon: Icon(
        iconData,
        color: Colors.grey,
        size: size ?? 24,
      ),
    );
  }
}
