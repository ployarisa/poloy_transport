import 'package:flutter/material.dart';

class MyConstant {
  //field ให้ค่าอย่างเดียว ค่าเดี่ยวๆ
  static Color primary = Color.fromARGB(255, 49, 81, 185);
  static Color dark = Color.fromARGB(255, 42, 49, 54);
  static Color light = Color.fromARGB(255, 127, 203, 216);

  static List<String> typeUsers = [
    'Owner',
    'Customer',
    'Driver',
  ];
  //method กลุ่มของ field

  static String pathRegister ='https://www.rollerglobal.com/api/api/Member/register';

  BoxDecoration curveBorderBox() => BoxDecoration(
        border: Border.all(color: MyConstant.dark),
        borderRadius: BorderRadius.circular(15),
      );

  BoxDecoration planBox() => BoxDecoration(color: light.withOpacity(0.5));

  BoxDecoration imageBox() => const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/bg.jpg'),
          fit: BoxFit.cover,
          opacity: 100,
        ),
      );

  TextStyle h1style() {
    return TextStyle(
      color: dark,
      fontSize: 36,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle h2style() {
    return TextStyle(
      color: dark,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle h3style() {
    return TextStyle(
      color: dark,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    );
  }

  TextStyle h3Activestyle() {
    return TextStyle(
      color: Color.fromARGB(255, 61, 30, 233),
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
  }
}//class
