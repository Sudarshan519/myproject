import 'dart:math';

import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mechanicfinder/src/controller/mechanicList.dart';
import 'package:mechanicfinder/src/models/mechanic.dart';
import 'package:mechanicfinder/src/pages/request_service.dart';
import 'package:mechanicfinder/src/widgets/const.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';
import '../models/distance.dart';

Future<Position> _determinePermission() async {
  bool serviceEnabled;
  LocationPermission permission;
  // List<Mechanic> mechan=mechanic.sort()

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permantly denied, we cannot request permissions.');
  }

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      return Future.error(
          'Location permissions are denied (actual value: $permission).');
    }
  }
  return null;
  // return await Geolocator.getCurrentPosition();
}

class DetailPage extends StatefulWidget {
  final String servicesname;
  final String image;
  DetailPage(this.servicesname, this.image);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final ScrollController scrollController = ScrollController();
  double mylatitude;
  double mylongitude;
  List<DistanceModel> dist = [];
  Position mechaniclocation;
  @override
  void initState() {
    super.initState();
    _determinePermission();
    getPosition();
    getmechanic();
  }

  // double distance(mylatitude, mylongitude, otherlat, otherlong) {
  //   double distanceInMeters = Geolocator.distanceBetween(
  //       mylatitude, mylongitude, otherlat, otherlong);
  //   // print(distanceInMeters);

  //   return (distanceInMeters / 1000);
  //   // final harvesine = new Haversine.fromDegrees(
  //   //     latitude1: mylatitude,
  //   //     longitude1: mylongitude,
  //   //     latitude2: otherlat,
  //   //     longitude2: otherlong);
  //   // return (harvesine.distance()/1000).toStringAsFixed(2);
  // }
//vincinety
  double getVincentyDistance(
      double lat1, double lon1, double lat2, double lon2) {
    double a = 6378137, b = 6356752.314245, f = 1 / 298.257223563;

    double L = 22 / 7 / 180 * (lon2 - lon1);

    double U1 = atan((1 - f) * tan(22 / 7 / 180 * (lat1)));

    double U2 = atan((1 - f) * tan(22 / 7 / 180 * (lat2)));

    double sinU1 = sin(U1), cosU1 = cos(U1);

    double sinU2 = sin(U2), cosU2 = cos(U2);

    double cosSqAlpha, sinSigma, cos2SigmaM, cosSigma, sigma;

    double lambda = L, lambdaP, iterLimit = 100;

    do {
      double sinLambda = sin(lambda), cosLambda = cos(lambda);

      sinSigma = sqrt((cosU2 * sinLambda) * (cosU2 * sinLambda) +
          (cosU1 * sinU2 - sinU1 * cosU2 * cosLambda) *
              (cosU1 * sinU2 - sinU1 * cosU2 * cosLambda));

      if (sinSigma == 0) return 0;

      cosSigma = sinU1 * sinU2 + cosU1 * cosU2 * cosLambda;

      sigma = atan2(sinSigma, cosSigma);

      double sinAlpha = cosU1 * cosU2 * sinLambda / sinSigma;

      cosSqAlpha = 1 - sinAlpha * sinAlpha;

      cos2SigmaM = cosSigma - 2 * sinU1 * sinU2 / cosSqAlpha;

      double C = f / 16 * cosSqAlpha * (4 + f * (4 - 3 * cosSqAlpha));

      lambdaP = lambda;

      lambda = L +
          (1 - C) *
              f *
              sinAlpha *
              (sigma +
                  C *
                      sinSigma *
                      (cos2SigmaM +
                          C * cosSigma * (-1 + 2 * cos2SigmaM * cos2SigmaM)));
    } while ((lambda - lambdaP).abs() > 1e-12 && --iterLimit > 0);

    if (iterLimit == 0) return 0;

    double uSq = cosSqAlpha * (a * a - b * b) / (b * b);

    double A =
        1 + uSq / 16384 * (4096 + uSq * (-768 + uSq * (320 - 175 * uSq)));

    double B = uSq / 1024 * (256 + uSq * (-128 + uSq * (74 - 47 * uSq)));

    double deltaSigma = B *
        sinSigma *
        (cos2SigmaM +
            B /
                4 *
                (cosSigma * (-1 + 2 * cos2SigmaM * cos2SigmaM) -
                    B /
                        6 *
                        cos2SigmaM *
                        (-3 + 4 * sinSigma * sinSigma) *
                        (-3 + 4 * cos2SigmaM * cos2SigmaM)));

    double s = b * A * (sigma - deltaSigma);
    return s;
  }
//   double distance(
//     double lat1,
//     double lon1,
//     double lat2,
//     double lon2,
//   ) {
// //ts equatorial region is spherical and poles are flat. The total mass of the earth is 5.972 × 1024kg. Its diameter is 12,742 km and the equatorial radius is 6,371 km.

//     var EarthRadius = 6378000; //137.0; //6357 to 6367// WGS84 major axis
//     double distance = 2 *
//         EarthRadius *
//         asin(sqrt(pow(sin(lat2 - lat1) / 2, 2) +
//             cos(lat1) * cos(lat2) * pow(sin(lon2 - lon1) / 2, 2)));

//     return distance / 1000;
//   }

  var alldist = [];
  Future getPosition() async {
    await Geolocator.getCurrentPosition().then((value) {
      setState(() {
        mylatitude = value.latitude;
        mylongitude = value.longitude;
      });
    });
  }

  // sortlist() {
  //   final Map<double, MechanicModel> mappings = {
  //     for (int i = 0; i < num.length; i++) num[i]: mechanics[i]
  //   };
  //   num.sort();
  //   mechanics = [for (double n in num) mappings[n]];
  //   print(mechanics[0]);
  //   print(num);
  // }

//  Future _getLocation() async
//       {
//         Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//         debugPrint('location: ${position.latitude}');
//         final coordinates = new Coordinates(position.latitude, position.longitude);
//         var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
//         var first = addresses.first;
//         print("${first.featureName} : ${first.addressLine}");
//       }
  List<MechanicModel> mechanics = [];
  var filtermechanics = [];
  List<double> num = [];

  getmechanic() async {
    await getPosition();

    List<MechanicModel> list = await mechanicService.getList();
    List<DistanceModel> d = [];
    list.forEach((element) {
      DistanceModel mod = DistanceModel()
        ..name = element.mechanicName
        ..id = getVincentyDistance(
            mylatitude, mylongitude, element.latitude, element.longitude)
        ..latitude = element.latitude
        ..longitude = element.longitude
        ..mechanicindex = list.indexOf(element);
      print(list.indexOf(element));
      print(mod.mechanicindex);
      d.add(mod);
      print(mod.id);
    });
    d.sort((a, b) => a.id.compareTo(b.id));
    d.forEach((element) {
      print(element.id);
    });
    setState(() {
      dist = d;
      mechanics = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blueGrey.withOpacity(.4),
                image: DecorationImage(
                  image: AssetImage(
                    widget.image,
                  ),
                  fit: BoxFit.fill,
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 30,
                    color: kShadowColor,
                  ),
                ],
              ),
              // height: height * .34,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  top: 30,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.grey[800],
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            // Padding(
            //   padding: const EdgeInsets.only(left: 18.0),
            //   child: Text(
            //     widget.servicesname,
            //     textAlign: TextAlign.start,
            //     style: TextStyle(
            //         color: Colors.grey[700],
            //         fontSize: 16,
            //         fontWeight: FontWeight.bold),
            //   ),
            // ),
            // SizedBox(height: 20),
            // filtermechanics.length != 0
            //     ? Text('Recommended Service')
            //     : Text(''),
            // SizedBox(height: 10),
            // filtermechanics.length == 0
            //     ? Text('')
            //     : Container(
            //         height: 200,
            //         child: filtermechanics.length != 0
            //             ? ListView.builder(
            //                 controller: scrollController,
            //                 itemCount: filtermechanics.length,
            //                 itemBuilder: (_, i) {
            //                   return Container(
            //                     decoration: BoxDecoration(
            //                       borderRadius: BorderRadius.circular(20),
            //                       color: Colors.white,
            //                       boxShadow: [
            //                         BoxShadow(
            //                           offset: Offset(0, 4),
            //                           blurRadius: 30,
            //                           color: kShadowColor,
            //                         ),
            //                       ],
            //                     ),
            //                     margin: EdgeInsets.only(
            //                         left: 10, right: 10, bottom: 10),
            //                     width: double.infinity,
            //                     child: InkWell(
            //                       onTap: () {
            //                         print(dist[i].mechanicindex);
            //                         Get.to(CustomMap(
            //                             service: widget.servicesname,
            //                             mylatitude: mylatitude,
            //                             mylongitude: mylongitude,
            //                             mechanic:
            //                                 mechanics[dist[i].mechanicindex]));
            //                         // Navigator.of(context)
            //                         //     .push(MaterialPageRoute(builder: (_) {
            //                         //   return ServiceRequestPage(mylatitude,mylongitude,mechanics[i].mechanicName);
            //                         //}));
            //                       },
            //                       child: Padding(
            //                         padding: const EdgeInsets.all(10.0),
            //                         child: Column(
            //                           crossAxisAlignment:
            //                               CrossAxisAlignment.start,
            //                           children: [
            //                             SizedBox(height: 10),
            //                             Text(
            //                               dist[i].name,
            //                               style: TextStyle(
            //                                   color: Colors.grey[600],
            //                                   fontSize: 16,
            //                                   fontWeight: FontWeight.bold),
            //                             ),
            //                             Text("${dist[i].id} km"),
            //                           ],
            //                         ),
            //                       ),
            //                     ),
            //                   );
            //                 })
            //             : Text('')),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child:Row(children: [ Text('All mechanic',
                  style: TextStyle(
                    fontSize: 20,
                  )),Spacer(),Text('Sort By: Distance',style: TextStyle(fontSize:16,color:Colors.grey),),],)
            ),
            Container(
                height: MediaQuery.of(context).size.height * .6,
                child: mylatitude != null && mechanics.length != null
                    ? ListView.builder(
                      padding: EdgeInsets.only(left:10),                        controller: scrollController,
                        itemCount: mechanics.length,
                        itemBuilder: (_, i) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 4),
                                  blurRadius: 30,
                                  color: kShadowColor,
                                ),
                              ],
                            ),
                            margin: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            width: double.infinity,
                            child: InkWell(
                              onTap: () {
                                Get.to(CustomMap(
                                    service: widget.servicesname,
                                    mylatitude: mylatitude,
                                    mylongitude: mylongitude,
                                    mechanic:
                                        mechanics[dist[i].mechanicindex]));
                                // Navigator.of(context)
                                //     .push(MaterialPageRoute(builder: (_) {
                                //   return ServiceRequestPage(mylatitude,mylongitude,mechanics[i].mechanicName);
                                //}));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10),
                                    Text(
                                      "Location :${dist[i].name}",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        "Distance: ${(dist[i].id / 1000).toStringAsFixed(2)} km"),
                                    // Text(
                                    //     "Distance : ${distance(mylatitude, mylongitude, mechanics[i].latitude, mechanics[i].longitude).toStringAsFixed(2)}km")
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                    : Center(
                        child: CircularProgressIndicator(),
                      )),
          ],
        ),
      ),
    );
  }
}

class CustomMap extends StatefulWidget {
  const CustomMap({
    Key key,
    this.mylatitude,
    this.mylongitude,
    this.mechanic,
    this.service,
  }) : super(key: key);
  final String service;
  final double mylatitude;
  final double mylongitude;
  final MechanicModel mechanic;

  @override
  _CustomMapState createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
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
          LatLng(widget.mechanic.latitude, widget.mechanic.longitude),
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
                zoom: 16.0,
              ),
              compassEnabled: true,
              polylines: Set<Polyline>.of([
                //    _buildPolyine(widget.shops[widget.selectedDistance], shopicon),
                Polyline(
                    polylineId: PolylineId('a'),
                    color: Colors.blueAccent,
                    points: [
                      LatLng(widget.mylatitude, widget.mylongitude),
                      LatLng(
                          widget.mechanic.latitude, widget.mechanic.longitude)
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
                    position: LatLng(
                        widget.mechanic.latitude, widget.mechanic.longitude),
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20)),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .2,
                alignment: Alignment.bottomCenter,
                child: Column(children: [
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.all(20),
                    width: double.infinity,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.red))),
                      onPressed: () {
                        Get.to(ResuestService(
                            service: widget.service,
                            mylatitude: widget.mylatitude,
                            mylongitude: widget.mylongitude,
                            mechanic: widget.mechanic));
                      },
                      child: Text('Send Request'),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ]),
              ),
            ),
          ],
        ));
  }
}
