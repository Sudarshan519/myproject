import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:haversine/haversine.dart';
import 'package:mechanicfinder/src/controller/mechanicList.dart';
import 'package:mechanicfinder/src/models/mechanic.dart';
import 'package:mechanicfinder/src/pages/request_service.dart';
import 'package:mechanicfinder/src/widgets/const.dart';

_determinePermission() async {
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
  //return await Geolocator.getCurrentPosition();
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
    final harvesine = new Haversine.fromDegrees(
        latitude1: otherlat,
        longitude1: otherlong,
        latitude2: mylatitude,
        longitude2: mylongitude);

    return harvesine.distance() / 1000;
  }

  Future getPosition() async {
    await Geolocator.getCurrentPosition().then((value) {
      print(value.latitude);
      setState(() {
        mylatitude = value.latitude;
        mylongitude = value.longitude;
      });
    });
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
  getmechanic() async {
    var list = await mechanic.getList();

    setState(() {
      mechanics = list;
    });
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
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_) {
                                  return ServiceRequestPage(mylatitude,
                                      mylongitude, mechanics[i].mechanicName);
                                }));
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
                                        "Distance : ${distance(mylatitude, mylongitude, mechanics[i].latitude, mechanics[i].longitude).toStringAsFixed(2)} km")
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
