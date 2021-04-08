import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/location.dart';
import 'package:favorite_button/favorite_button.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController mapController;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  BitmapDescriptor pinLocationIcon;

  populateClients() {
    FirebaseFirestore.instance.collection("locationData").get().then((docs) {
      if (docs.docs.isNotEmpty) {
        for (int i = 0; i < docs.docs.length; ++i) {
          initMarker(docs.docs[i], docs.docs[i].id);
        }
      }
      print('populateClients sucess');
    });
  }

  void initMarker(bus, busId) {
    var markerIdVal = busId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(bus["lat"], bus["long"]),
    );
    setState(() {
      markers[markerId] = marker;
    });
    print('initmarker sucess');
  }

  Location _location = Location();
  var l;
  
  LatLng _initialcameraposition = LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _location.onLocationChanged.listen((l) {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(l.latitude, l.longitude),
            zoom: 11,
          ),
        ),
      );
      _initialcameraposition = LatLng(l.latitude, l.longitude);
      populateClients();
      print('_onMapCreated sucess');
    });
    return l;
  }

  Future<void> addFavorite(id, genre) async {
    await FirebaseFirestore.instance
        .collection("userPref")
        .where('userId', isEqualTo: id)
        .get()
        .then((value) {
      value.docs.forEach((result) {
        var a2 = result.data()[genre];
        a2++;
        var docId = result.id;
        CollectionReference userPrefs =
            FirebaseFirestore.instance.collection('userPref');

        return userPrefs
            .doc(docId)
            .update({genre: a2})
            .then((value) => print("Pref Updated"))
            .catchError((error) => print("Failed to update pref: $error"));
      });
    });
  }

  Future<void> removeFavorite(id, genre) async {
    await FirebaseFirestore.instance
        .collection("userPref")
        .where('userId', isEqualTo: id)
        .get()
        .then((value) {
      value.docs.forEach((result) {
        print('Step One');
        var a2 = result.data()[genre];
        a2 = a2 - 1;
        print(a2);
        var docId = result.id;
        CollectionReference userPrefs =
            FirebaseFirestore.instance.collection('userPref');

        return userPrefs
            .doc(docId)
            .update({genre: a2})
            .then((value) => print("Pref Updated"))
            .catchError((error) => print("Failed to update pref: $error"));
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    final userId = user.uid;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue[50],
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 6,
                child: GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: _initialcameraposition),
                  onMapCreated: _onMapCreated,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  mapType: MapType.normal,
                  markers: Set<Marker>.of(markers.values),
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  children: <Widget>[
                    Flexible(
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('locationData')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) return new Text('Loading...');
                          return new ListView(
                            children: snapshot.data.docs.map((docsTitles) {
                              return new ListTileTheme(
                                  tileColor: Colors.teal,
                                child: ListTile(
                                  title: new Text(docsTitles.data()['name']),
                                  subtitle:
                                      new Text(docsTitles.data()['address']),
                                  trailing: FavoriteButton(
                                    valueChanged: (_isFavorite) {
                                      if (_isFavorite == true) {
                                        print('Is Favorite $_isFavorite');
                                        addFavorite(
                                            userId, docsTitles.data()['genre']);
                                      } else if (_isFavorite == false){
                                        print('is favorite2 $_isFavorite');
                                        removeFavorite(
                                            userId, docsTitles.data()['genre']);
                                      }
                                    },
                                    iconSize: 30,
                                  ),

                                onTap: () {
                                  print('Tap Success');

                                }
                              ));
                            }).toList(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
