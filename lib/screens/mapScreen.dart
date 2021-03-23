import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController mapController;
  Location _location = Location();
  var l;
  LatLng _initialcameraposition = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _location.onLocationChanged.listen((l) {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 11,),
        ),
      );
    });
    return l;
  }

  @override
  Widget build(BuildContext context) {
    //CollectionReference userPref =
    //FirebaseFirestore.instance.collection('userPref');
    //final FirebaseAuth auth = FirebaseAuth.instance;
    //final User user = auth.currentUser;
    //final userId = user.uid;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue[50],
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _initialcameraposition
          ),
          onMapCreated: _onMapCreated,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          mapType: MapType.normal,
        ),
      ),
    );
  }
}
