import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ploy_transport/bodys/get_location.dart';
import 'package:ploy_transport/bodys/read_api_token.dart';
import 'package:ploy_transport/utility/my_constant.dart';
import 'package:ploy_transport/utility/my_dialog.dart';
import 'package:ploy_transport/widgets/show_listtitle.dart';
import 'package:ploy_transport/widgets/showtext.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Myservice extends StatefulWidget {
  const Myservice({Key? key}) : super(key: key);

  @override
  State<Myservice> createState() => _MyserviceState();
}

class _MyserviceState extends State<Myservice> {
  String? tokenUser;
  bool load = true;

  var wigets = <Widget>[];
  int indexWidget = 0;

  @override
  void initState() {
    super.initState();
    findToken();
  }

  Future<void> findToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    tokenUser = preferences.getString(MyConstant.keyToken);

    wigets.add(ReadApiToken(
      token: tokenUser!,
    ));
    wigets.add(const GetLocationShowMap());
    load = false;
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: Stack(
          children: [
            Column(
              children: [
                UserAccountsDrawerHeader(accountName: null, accountEmail: null),
                InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.pop(context);
                      indexWidget = 0;
                    });
                  },
                  child: const ShowListTile(
                    title: 'ReadAPI',
                    subTitle: 'Read API by Token',
                    path: 'images/api.png',
                    size: 36,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.pop(context);
                      indexWidget = 1;
                    });
                  },
                  child: const ShowListTile(
                    title: 'GetLocation',
                    subTitle: 'Get Location and show Map',
                    path: 'images/location.png',
                    size: 36,
                  ),
                ),
              ],
            ),
            newSignOut(context: context),
          ],
        ),
      ),
      body: load ? CircularProgressIndicator() : wigets[indexWidget],
    );
  }

  Column newSignOut({required BuildContext context}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            MyDialog(context: context).twoWayDialog(
                title: 'confirm SignOut',
                subTitle: 'Are You sure',
                label1: 'Sig Out',
                label2: 'Cancel',
                pressFunc1: () {
                  processSignOut(context: context);
                },
                pressFunc2: () {
                  Navigator.pop(context);
                });
          },
          child: const ShowListTile(
              size: 48,
              title: 'Sign Out',
              subTitle: 'Sign Out and Move To Authen',
              path: 'images/logout.png'),
        ),
      ],
    );
  }

  Future<void> processSignOut({required BuildContext context}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear().then((value) {
      Navigator.pushNamedAndRemoveUntil(context, '/authen', (route) => false);
    });
  }
}
