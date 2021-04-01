import 'package:flutter/material.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mechanicfinder/src/controller/mechanicList.dart';
import 'package:mechanicfinder/src/models/mechanic.dart';
import 'package:mechanicfinder/src/widgets/const.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';

import 'request_service.dart';

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

  Position mechaniclocation;
  @override
  void initState() {
    super.initState();
    _determinePermission();
    getPosition();
    getmechanic();
  }

  double distance(mylatitude, mylongitude, otherlat, otherlong) {
    double distanceInMeters = Geolocator.distanceBetween(
        mylatitude, mylongitude, otherlat, otherlong);
    // print(distanceInMeters);

    return (distanceInMeters / 1000);
    // final harvesine = new Haversine.fromDegrees(
    //     latitude1: mylatitude,
    //     longitude1: mylongitude,
    //     latitude2: otherlat,
    //     longitude2: otherlong);
    // return (harvesine.distance()/1000).toStringAsFixed(2);
  }

  var alldist = [];
  Future getPosition() async {
    await Geolocator.getCurrentPosition().then((value) {
      setState(() {
        mylatitude = value.latitude;
        mylongitude = value.longitude;
      });
    });
  }

  getDistance() {
    mechanics.forEach((element) {
      setState(() {
        num.add(distance(
            mylatitude, mylongitude, element.latitude, element.longitude));
      });
    });
  }

  sortlist() {
    final Map<double, MechanicModel> mappings = {
      for (int i = 0; i < num.length; i++) num[i]: mechanics[i]
    };
    num.sort();
    mechanics = [for (double n in num) mappings[n]];
    print(mechanics[0]);
    print(num);
  }

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
  List<MechanicModel> filtermechanics = [];
  List<double> num = [];
  getmechanic() async {
    // var filterlist = await mechanicService.filterMechaic('s');
    var list = await mechanicService.getList();
    // setState(() {
    //   filtermechanics = filterlist;
    // });

    setState(() {
      mechanics = list;
    });
    filterList();
  }

  filterList() async {
    List<Placemark> place=await getlocation();
    mechanics.forEach((element) {
      if (element.mechanicName.contains(place[0].name) ||
          element.mechanicName.contains(place[0].locality) ||
          element.city.contains('samakhushi') ||
          element.address.contains('gongabu')) filtermechanics.add(element);
    });
  }

  getlocation() async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(mylatitude, mylongitude);
    return placemarks;
  }

  @override
  Widget build(BuildContext context) {
    // MyProvider provider = Provider.of<MyProvider>(context);
    //provider.getMechnicsList();

    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
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
              height: height * .34,
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
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text(
                widget.servicesname,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Text('Recommended Service'),
            SizedBox(height: 10),
            Container(
                height: 200,
                //  color: Colors.green,
                child: ListView.builder(
                    controller: scrollController,
                    itemCount: filtermechanics.length,
                    itemBuilder: (_, i) {
                      if (filtermechanics.length != 0)
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 4),
                                blurRadius: 30,
                                color: kShadowColor,
                              ),
                            ],
                          ),
                          margin:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          width: double.infinity,
                          child: InkWell(
                            onTap: () {
                              Get.to(CustomMap(
                                  mylatitude: mylatitude,
                                  mylongitude: mylongitude,
                                  mechanic: mechanics[i]));
                              // Navigator.of(context)
                              //     .push(MaterialPageRoute(builder: (_) {
                              //   return ServiceRequestPage(mylatitude,mylongitude,mechanics[i].mechanicName);
                              //}));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Text(
                                    mechanics[i].mechanicName,
                                    style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(mechanics[i].city),
                                  Text(
                                      "Distance : ${distance(mylatitude, mylongitude, mechanics[i].latitude, mechanics[i].longitude).toStringAsFixed(2)}km")
                                ],
                              ),
                            ),
                          ),
                        );
                    })),
            Text('All mechanic'),
            Container(
                height: MediaQuery.of(context).size.height * .6,
                child: mylatitude != null && mechanics.length != null
                    ? ListView.builder(
                        controller: scrollController,
                        itemCount: mechanics.length,
                        itemBuilder: (_, i) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
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
                                    mylatitude: mylatitude,
                                    mylongitude: mylongitude,
                                    mechanic: mechanics[i]));
                                // Navigator.of(context)
                                //     .push(MaterialPageRoute(builder: (_) {
                                //   return ServiceRequestPage(mylatitude,mylongitude,mechanics[i].mechanicName);
                                //}));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10),
                                    Text(
                                      mechanics[i].mechanicName,
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(mechanics[i].city),
                                    Text(
                                        "Distance : ${distance(mylatitude, mylongitude, mechanics[i].latitude, mechanics[i].longitude).toStringAsFixed(2)}km")
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
  }) : super(key: key);

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
                  Marker(
                    markerId: MarkerId('marker_1'),
                    position: LatLng(47.6, 8.8796),
                    consumeTapEvents: true,
                    infoWindow: InfoWindow(
                      title: 'PlatformMarker',
                      snippet: "Hi I'm a Platform Marker",
                    ),
                    onTap: () {
                      // print("Marker tapped");
                    },
                  ),
                  Marker(
                    markerId: MarkerId('marker_1'),
                    position: LatLng(
                        widget.mechanic.latitude, widget.mechanic.longitude),
                    consumeTapEvents: true,
                    infoWindow: InfoWindow(
                      title: 'PlatformMarker',
                      snippet: "Hi I'm a Platform Marker",
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
                          tilt: 30.0,
                          zoom: 18,
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
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20)),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .2,
                alignment: Alignment.bottomCenter,
                //   color: Colors.green,
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

            // Positioned(
            //   bottom: 0,
            //   child: Container(
            //     height: 65,
            //     color: Colors.green,
            //   ),
            // )
          ],
        ));
  }
}
