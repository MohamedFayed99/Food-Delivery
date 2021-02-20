import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fooddelivery/screens/home_screen.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
//import 'package:mudah_gps/showMap.dart';
/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.

class Map extends StatefulWidget {
  static String id = "Map";

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  final Geolocator geolocator = Geolocator();
  final GeocodingPlatform _geocodingPlatform = GeocodingPlatform.instance;
  Position _currentPosition;
  String _currentAddress;
  List<Marker> allMarkers = [];

  setMarkers() {
    return allMarkers;
  }

  String inputaddr = '';

  @override
  addToList() async {
    final query = inputaddr;
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    FirebaseFirestore.instance.collection('marker').add({
      'coords':
          new GeoPoint(first.coordinates.latitude, first.coordinates.longitude),
      'place': first.featureName
    });
  }

  Widget loadMap() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('marker').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Text('Loading maps...Please Wait');
        for (int i = 0; i < snapshot.data.documents.length; i++) {
          allMarkers.add(new Marker(
              width: 45.0,
              height: 45.0,
              point: new LatLng(snapshot.data.documents[i]['coords'].latitude,
                  snapshot.data.documents[i]['coords'].longitude),
              builder: (context) => new Container(
                    child: IconButton(
                      icon: Icon(Icons.location_on),
                      color: Colors.red,
                      iconSize: 45.0,
                      onPressed: () {
                        print(snapshot.data.documents[i]['place']);
                      },
                    ),
                  )));
        }

        return new FlutterMap(
            options: new MapOptions(
              center: new LatLng(5.3332774, 100.3065249),
              minZoom: 10.0,
            ),
            layers: [
              new TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c']),
              new MarkerLayerOptions(markers: allMarkers),
            ]);
      },
    );
  }

  _getCurrentLocation() async {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await _geocodingPlatform.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

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

    return await Geolocator.getCurrentPosition();
  }

  final TextEditingController _searchControl = new TextEditingController();

  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return StreamBuilder<Object>(
        stream: FirebaseFirestore.instance.collection('marker').snapshots(),
        builder: (context, snapshot) {
          return Container(
            color: Colors.white,
            child: ListView(children: [
              Card(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        height: 50,
                        width: 260,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 0.38),
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                        ),
                        child: TextField(
                          onChanged: (String enteredLoc) {
                            setState(() {
                              inputaddr = enteredLoc;
                            });
                          },
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.all(10.0),
                            disabledBorder: InputBorder.none,
                            hintText: translator.translate(
                                "Search for a region, or street. . ."),
                            hintStyle: TextStyle(
                              fontSize: 16.0,
                              color: Color.fromRGBO(0, 0, 0, 0.78),
                            ),
                          ),
                          maxLines: 1,
                          controller: _searchControl,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward,
                          size: 40,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ]),
              ),
              Container(
                  padding: EdgeInsets.all(8),
                  height: height * 0.7,
                  width: width * 0.8,
                  child: (_currentPosition != null)
                      ? FlutterMap(
                          options: MapOptions(
                            center: LatLng(_currentPosition.latitude,
                                _currentPosition.longitude),
                            zoom: 14,
                            interactive: true,
                          ),
                          layers: [
                            TileLayerOptions(
                                urlTemplate:
                                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                subdomains: ['a', 'b', 'c']),
                            new MarkerLayerOptions(
                              markers: [
                                new Marker(
                                  width: 80.0,
                                  height: 80.0,
                                  point: new LatLng(_currentPosition.latitude,
                                      _currentPosition.longitude),
                                  builder: (ctx) => new Container(
                                    child: Icon(
                                      Icons.location_on,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                new Marker(
                                  width: 80.0,
                                  height: 80.0,
                                  point: new LatLng(
                                      _currentPosition.latitude - 0.00112,
                                      _currentPosition.longitude - 0.052),
                                  builder: (ctx) => new Container(
                                    child: Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                new Marker(
                                  width: 80.0,
                                  height: 80.0,
                                  point: new LatLng(_currentPosition.latitude,
                                      _currentPosition.longitude - 0.202),
                                  builder: (ctx) => new Container(
                                    child: Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                new Marker(
                                  width: 80.0,
                                  height: 80.0,
                                  point: new LatLng(
                                      _currentPosition.latitude - 0.1002,
                                      _currentPosition.longitude - 0.0501102),
                                  builder: (ctx) => new Container(
                                    child: Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                new Marker(
                                  width: 80.0,
                                  height: 80.0,
                                  point: new LatLng(
                                      _currentPosition.latitude - 0.02011,
                                      _currentPosition.longitude - 0.002002),
                                  builder: (ctx) => new Container(
                                    child: Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                new Marker(
                                  width: 80.0,
                                  height: 80.0,
                                  point: new LatLng(30.048578, 30.97804),
                                  builder: (ctx) => new Container(
                                    child: Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                new Marker(
                                  width: 80.0,
                                  height: 80.0,
                                  point: new LatLng(30.0480550, 30.9564),
                                  builder: (ctx) => new Container(
                                    child: Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                new Marker(
                                  width: 80.0,
                                  height: 80.0,
                                  point: new LatLng(30.048578, 30.950067),
                                  builder: (ctx) => new Container(
                                    child: Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                new Marker(
                                  width: 80.0,
                                  height: 80.0,
                                  point: new LatLng(30.048578, 30.9567804),
                                  builder: (ctx) => new Container(
                                    child: Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        )),
              Container(
                  height: height * 0.05,
                  child: (_currentPosition != null && _currentAddress != null)
                      ? Text(
                          _currentAddress,
                          style: TextStyle(
                            inherit: false,
                            fontSize: 20,
                            color: Colors.red,
                          ),
                        )
                      : Text(
                          "",
                        )),
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  height: 50,
                  width: 260,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.38),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'its my location',
                      style: TextStyle(
                        color: Colors.black,
                        inherit: false,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                excludeFromSemantics: true,
                onTap: () {
                  Navigator.of(context).popAndPushNamed(HomeScreen.id);
                },
              ),
            ]),
          );
        });
  }
}
