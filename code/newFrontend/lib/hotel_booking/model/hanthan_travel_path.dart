import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class HanthanaTravelPath extends StatefulWidget {
  const HanthanaTravelPath({Key? key}) : super(key: key);

  @override
  State<HanthanaTravelPath> createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<HanthanaTravelPath> {
  late GoogleMapController googleMapController;
  static const CameraPosition initialPosition = CameraPosition(
      target: LatLng(7.253924853399335, 80.59193258728561), zoom: 18.0);
  Set<Marker> markers = {};

  // For tracking
  Set<Position> path = {};

  List<LatLng> mspoints = [
    const LatLng(7.252289334976221, 80.59301000760829),
    const LatLng(7.2535262227767925, 80.593007843434323),
    const LatLng(7.25466154748211, 80.59297761712543),
  ];

  int markLocationNumber = 0;

  List<LatLng> points = [];

  // final Polyline _polyline = const Polyline(
  //                       polylineId: PolylineId('1'),
  //                       points: [
  //                                 LatLng(19.0759837, 72.8776559),
  //                                 LatLng(28.679079, 77.069710),
  //                                 LatLng(26.850000, 80.949997),
  //                                 LatLng(24.879999, 74.629997),
  //                                 LatLng(16.166700, 74.833298),
  //                                 LatLng(12.971599, 77.594563),
  //                               ],
  //                       color: Colors.green,
  //                     );

  bool track = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Map App'),
          centerTitle: true,
        ),
        body: GoogleMap(
          initialCameraPosition: initialPosition,
          mapType: MapType.normal,
          markers: markers,
          polylines: {
            Polyline(
              polylineId: PolylineId('1'),
              points: points,
              color: Colors.red,
              width: 3,
            ),
            Polyline(
              polylineId: PolylineId('2'),
              points: mspoints,
              color: Colors.blue,
              width: 3,
            ),
          },
          onMapCreated: (GoogleMapController controller) {
            googleMapController = controller;
          },
        ),
        floatingActionButton:Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(width: 5),
            Container(
              height: 45.0,
              width: 135.0,
              child: FittedBox(
                child: FloatingActionButton.extended(
                  onPressed: () async {
                    markLocationNumber++;
                    track = false;

                    Position position = await _determinePosition();

                    googleMapController.animateCamera(
                        CameraUpdate.newCameraPosition(CameraPosition(
                            target:
                                LatLng(position.latitude, position.longitude),
                            zoom: 18)));

                    // markers.clear();

                    markers.add(Marker(
                        markerId: MarkerId('location$markLocationNumber'),
                        position:
                            LatLng(position.latitude, position.longitude)));

                    setState(() {});

                    await Future.delayed(const Duration(seconds: 1));
                  },
                  label: Text("Mark Location"),
                  icon: const Icon(Icons.add_circle_outline),
                  heroTag: "btn0",
                ),
              ),
            ),

           // SizedBox(height: 2),

            // --------------------------------------------- Show Milestones -------------------------------------------------
            Container(
              height: 45.0,
              width: 150.0,
              child: FittedBox(
                child: FloatingActionButton.extended(
                  onPressed: () async {
                    //markers.clear();

                    ///// Add all Milesotes below

                    /// MS1
                    markers.add(Marker(
                      markerId: const MarkerId("MS1"),
                      position:
                          const LatLng(7.252289334976221, 80.59301000760829),
                      icon: BitmapDescriptor.fromBytes(
                          await getBytesFromAsset('assets/img/ms.png', 60)),
                    ));

                    /// MS2
                    markers.add(Marker(
                      markerId: const MarkerId("MS2"),
                      position:
                          const LatLng(7.2535262227767925, 80.593007843434323),
                      icon: BitmapDescriptor.fromBytes(
                          await getBytesFromAsset('assets/img/ms.png', 60)),
                    ));

                    /// MS3
                    markers.add(Marker(
                      markerId: const MarkerId("MS3"),
                      position:
                          const LatLng(7.25466154748211, 80.59297761712543),
                      icon: BitmapDescriptor.fromBytes(
                          await getBytesFromAsset('assets/img/ms.png', 60)),
                    ));

                    setState(() {});
                  },
                  label: Text("Show Milestones"),
                  icon: const Icon(Icons.flag),
                  heroTag: "btn1",
                ),
              ),
            ),

            //SizedBox(height: 2),

            // --------------------------------------------------------------------------
            Container(
              height: 45.0,
              width: 120.0,
              child: FittedBox(
                child: FloatingActionButton.extended(
                  onPressed: () async {
                    track = true;
                    path.clear();
                    //markers.clear();

                    while (track) {
                      Position position = await _determinePosition();

                      // double latDiff = 0;
                      // double lonDiff = 0;

                      // if (path.length > 0) {
                      //   latDiff = position.latitude -
                      //       path.elementAt(path.length - 1).latitude;

                      //   lonDiff = position.longitude -
                      //       path.elementAt(path.length - 1).longitude;
                      // }

                      // if (path.length == 0 ||
                      //     (latDiff > 0.0000001 && lonDiff > 0.0000000001)) {
                      path.add(position);
                      points.add(LatLng(position.latitude, position.longitude));

                      googleMapController.animateCamera(
                          CameraUpdate.newCameraPosition(CameraPosition(
                              target:
                                  LatLng(position.latitude, position.longitude),
                              zoom: 18)));

                      // markers.clear();

                      for (int i = 0; i < path.length; i++) {
                        markers.add(Marker(
                          markerId: MarkerId(i.toString()),
                          position: LatLng(path.elementAt(i).latitude,
                              path.elementAt(i).longitude),
                          icon: BitmapDescriptor.fromBytes(
                              await getBytesFromAsset(
                                  'assets/img/reddot.png', 20)),
                        ));
                        //icon: BitmapDescriptor.defaultMarker, ));

                        setState(() {});

                        // points.add(LatLng(7.75467254442788, 81.5952258202641));

                      }
                      // }
                      await Future.delayed(const Duration(seconds: 5));
                    }
                  },
                  label: Text("Track Path"),
                  icon: const Icon(Icons.navigation),
                  heroTag: "btn2",
                  backgroundColor: Colors.red,
                ),
              ),
            ),
          ],
        )
        );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error("Location Service Disabled !");
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location Service Denied (After request) !");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location Service Denied Forever !");
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

  // final LocationSettings locationSettings = LocationSettings(
  //   accuracy: LocationAccuracy.high,
  //   distanceFilter: 1,
  // );
  // StreamSubscription<Position> positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen(
  //         (Position? position) {
  //       print(position == null ? 'Unknown' : '${position.latitude.toString()}, ${position.longitude.toString()}');
  //     });

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
