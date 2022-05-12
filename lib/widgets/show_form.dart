// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:ploy_transport/utility/my_constant.dart';
import 'package:ploy_transport/widgets/showtext.dart';

class ShowForm extends StatelessWidget {
  final String label;
  final IconData iconData;
  final bool? obsecu;
  final Function(String) changeFunc;
  final TextInputType? textInputType;
  final TextEditingController? controller;

  const ShowForm({
    Key? key,
    required this.label,
    required this.iconData,
    this.obsecu,
    required this.changeFunc,
    this.textInputType,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      height: 50,
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType ?? TextInputType.text,
        onChanged: changeFunc,
        obscureText: obsecu ?? false,
        style: MyConstant().h3style(),
        decoration: InputDecoration(
          fillColor: Color.fromARGB(255, 252, 252, 252).withOpacity(0.7),
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          suffixIcon: Icon(
            iconData,
            color: MyConstant.dark,
          ),
          //focus และ enable
          label: ShowText(label: label),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.dark),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.light),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
