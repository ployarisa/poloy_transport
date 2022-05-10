// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:ploy_transport/utility/my_constant.dart';

class ShowButton extends StatelessWidget {
  final String label;
  final Function() pressFunc;
  const ShowButton({
    Key? key,
    required this.label,
    required this.pressFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: 250,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: MyConstant.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13))
        ),
        onPressed: pressFunc,
        child: Text(label),
      ),
    );
  }
}
