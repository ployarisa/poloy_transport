// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ploy_transport/main.dart';
import 'package:ploy_transport/models/profile_model.dart';
import 'package:ploy_transport/utility/my_constant.dart';
import 'package:ploy_transport/widgets/showtext.dart';

class ReadApiToken extends StatefulWidget {
  final String token;
  
  const ReadApiToken({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  State<ReadApiToken> createState() => _ReadApiTokenState();
}

class _ReadApiTokenState extends State<ReadApiToken> {
  String? token;
  ProfileModel? profileModel;
  bool load = true;

  @override
  void initState() {
    super.initState();
    token = widget.token;
    readProfile();
  }

  Future<void> readProfile() async {
    Dio dio = Dio();
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['Authorization'] = 'Barer $token';

    Map<String, dynamic> map = {};
    map['id'] = '105';
    map['role'] = 'Roller';

    await dio.post(MyConstant.pathGetProfile, data: map).then((value) {
      // print('## value from token ===>> $value');
      profileModel = ProfileModel.fromJson(value.data);

      load = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: load
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                ShowText(
                    label: 'name : ${profileModel!.responseData!.fullname}'),
              ],
            ),
    );
  }
}
