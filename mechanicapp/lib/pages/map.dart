import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechanicapp/controller/mechanic_controller.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';

class CustomMap extends StatefulWidget {
  CustomMap({
    Key key,
    this.mylatitude,
    this.mylongitude,
    this.service,
  }) : super(key: key);
  final String service;
  final double mylatitude;
  final double mylongitude;

  @override
  _CustomMapState createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  final userController = Get.find<UserController>();
  Marker _buildShopMarker(context, icon) {
    return Marker(
      markerId: MarkerId(context.id),
      icon: icon,
      position: LatLng(context.latitude, context.longitude),
      consumeTapEvents: true,
      infoWindow: InfoWindow(
        title: '${context.address}',
        snippet: "${context.shopName}",
      ),
      onTap: () async {
        //print("Marker tapped");
      },
    );
  }

  Polyline _buildPolyine(context, icon) {
    return Polyline(
        polylineId: PolylineId(context.id),
        color: Colors.blueAccent,
        points: [
          LatLng(userController.user.value.latitude,
              userController.user.value.longitude),
          LatLng(context.latitude, context.longitude)
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Map '),
        ),
        body: Stack(
          children: [
            PlatformMap(
              initialCameraPosition: CameraPosition(
                target: const LatLng(47.6, 8.8796),
                zoom: 13.0,
              ),
              compassEnabled: true,
              polylines: Set<Polyline>.of([
                //    _buildPolyine(widget.shops[widget.selectedDistance], shopicon),
                Polyline(
                    polylineId: PolylineId('a'),
                    color: Colors.blueAccent,
                    points: [
                      LatLng(widget.mylatitude, widget.mylongitude),
                      LatLng(userController.user.value.latitude,
                          userController.user.value.longitude)
                    ])
              ]),
              markers: Set<Marker>.of(
                [
                  // Marker(
                  //   markerId: MarkerId('marker_1'),
                  //   position: LatLng(47.6, 8.8796),
                  //   consumeTapEvents: true,
                  //   infoWindow: InfoWindow(
                  //     title: 'PlatformMarker',
                  //     snippet: "Hi I'm a Platform Marker",
                  //   ),
                  //   onTap: () {
                  //     // print("Marker tapped");
                  //   },
                  // ),
                  Marker(
                    markerId: MarkerId('marker_1'),
                    position: LatLng(userController.user.value.latitude,
                        userController.user.value.longitude),
                    consumeTapEvents: true,
                    infoWindow: InfoWindow(
                      title: 'Mechanic',
                      snippet: "Hi This is my location",
                    ),
                    onTap: () {
                      print("Marker tapped");
                    },
                  ),
                ],
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onTap: (location) => print('onTap: $location'),
              onCameraMove: (cameraUpdate) =>
                  print('onCameraMove: $cameraUpdate'),
              onMapCreated: (controller) {
                Future.delayed(Duration(seconds: 2)).then(
                  (_) {
                    controller.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          bearing: 270.0,
                          target: LatLng(widget.mylatitude, widget.mylongitude),
                          //  tilt: 30.0,
                          zoom: 16,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Container(
            //     decoration: BoxDecoration(
            //         color: Colors.grey[300],
            //         borderRadius: BorderRadius.circular(20)),
            //     width: double.infinity,
            //     height: MediaQuery.of(context).size.height * .2,
            //     alignment: Alignment.bottomCenter,
            //     child: Column(children: [
            //       SizedBox(height: 20),
            //       Container(
            //         margin: EdgeInsets.all(20),
            //         width: double.infinity,
            //         child: TextButton(
            //           style: TextButton.styleFrom(
            //               backgroundColor: Colors.green,
            //               primary: Colors.white,
            //               shape: RoundedRectangleBorder(
            //                   borderRadius: BorderRadius.circular(10),
            //                   side: BorderSide(color: Colors.red))),
            //           onPressed: () {},
            //           child: Text('Accept Request'),
            //         ),
            //       ),
            //       SizedBox(
            //         height: 40,
            //       ),
            //     ]),
            //   ),
            // ),
          ],
        ));
  }
}
