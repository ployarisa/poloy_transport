import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ploy_transport/utility/my_dialog.dart';

class GetLocationShowMap extends StatefulWidget {
  const GetLocationShowMap({Key? key}) : super(key: key);

  @override
  State<GetLocationShowMap> createState() => _GetLocationShowMapState();
}

class _GetLocationShowMapState extends State<GetLocationShowMap> {
  double? lat, log;
  bool load = true;
  @override
  void initState() {
    super.initState();
    findState();
  }

  

  Future<void> findState() async {
    bool locationEnable;
    LocationPermission locationPermission;

    locationEnable = await Geolocator.isLocationServiceEnabled();
    if (locationEnable) {
      // Enable Location Service
      locationPermission = await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.deniedForever) {
        MyDialog(context: context).normalDialog(
            title: 'Denyed Forever',
            subTitle: 'Please Opwn Premission',
            pressFunc: () {
              exit(0);
            });
      }

      if (locationPermission == LocationPermission.denied) {
        await Geolocator.requestPermission();
      } else {
        //Away
        print('Location Can Find');

        Position position = await findPosition();
        if (position != null) {
          lat = position.latitude;
          log = position.longitude;
          print('lat = $lat, long = $log');
          load = false;
          setState(() {});
        }
      }
    } else {
      MyDialog(context: context).normalDialog(
          title: 'Non Location Service',
          subTitle: 'Please Open service',
          pressFunc: () {
            exit(0);
          });
    }
  }

  Future<Position> findPosition() async {
    Position? position;
    try {
      position = await Geolocator.getCurrentPosition();
    } catch (e) {
      position = null;
    }
    return position!;
  }

  Set<Marker> myMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId('id'),
        position: LatLng(lat!, log!),
      )
    ].toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: load
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(lat!, log!),
                zoom: 16,
              ),
              onMapCreated: (value) {},
              markers: myMarker(),
            ),
    );
  }
}
