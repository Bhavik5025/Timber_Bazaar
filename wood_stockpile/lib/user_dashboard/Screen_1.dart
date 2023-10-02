import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:ui' as ui;

class Screen_1 extends StatefulWidget {
  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen_1> {
  GoogleMapController? mapController;
  Location location = Location();
  Set<Marker> markers = Set();
  dynamic let = 22.6708;
  dynamic long = 71.5724;
  var curlet;
  var curlong;
  Future<Uint8List> getba(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> findNearbyFurnitureShops() async {
    final apiKey = 'AIzaSyAr1dn7Gm4qQzKjgqocTqTCya1g8CKp7ZY';
    final locationData = await location.getLocation();

    final response = await http.get(
      Uri.parse(
          'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${curlet},${curlong}&radius=500&type=furniture_store&key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        final results = data['results'];

        // Clear existing markers

        for (var result in results) {
          final name = result['name'];
          final geometry = result['geometry'];
          final location = geometry['location'];
          final lat = location['lat'];
          final lng = location['lng'];

          // Add furniture marker to the map
          final Uint8List customMarkerIcon =
              await getba("assets/image/wood_factory.png", 90);

          markers.add(
            Marker(
                markerId: MarkerId(name),
                position: LatLng(lat, lng),
                infoWindow: InfoWindow(title: name),
                icon: BitmapDescriptor.fromBytes(customMarkerIcon)),
          );
        }

        setState(() {});
      }
    } else {
      throw Exception('Failed to load hospitals');
    }
  }

  @override
  void initState() {
    super.initState();
    // location.onLocationChanged.listen((locationData) {
    //   //   // Update the map's camera position to the current location
    //   mapController?.animateCamera(
    //     CameraUpdate.newCameraPosition(
    //       CameraPosition(
    //         target: LatLng(let, long),
    //         zoom: 12.0,
    //       ),
    //     ),
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            height: 500,
            child: GoogleMap(
              onMapCreated: (controller) {
                mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(let, long),
                zoom: 8.0,
              ),
              markers: markers,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            bool _serviceEnabled;
            PermissionStatus _permissionGranted;
            LocationData _locationData;
            final Uint8List customMarkerIcon =
                await getba("assets/image/location.png", 120);
            _serviceEnabled = await location.serviceEnabled();
            if (!_serviceEnabled) {
              _serviceEnabled = await location.requestService();
              if (!_serviceEnabled) {
                return;
              }
            }

            _permissionGranted = await location.hasPermission();
            if (_permissionGranted == PermissionStatus.denied) {
              _permissionGranted = await location.requestPermission();
              if (_permissionGranted != PermissionStatus.granted) {
                return;
              }
            }
            _locationData = await location.getLocation();

            setState(() {
              curlet = _locationData.latitude;
              curlong = _locationData.longitude;
              mapController!.animateCamera(CameraUpdate.newLatLngZoom(
                LatLng(curlet, curlong),
                15.0, // You can adjust the zoom level as needed
              ));
              let = _locationData.latitude;
              long = _locationData.longitude;
              markers.clear();
              markers.add(Marker(
                markerId: MarkerId("User"),
                position: LatLng(curlet, curlong),
                infoWindow: const InfoWindow(
                  title: "user",
                ),
                icon: BitmapDescriptor.fromBytes(customMarkerIcon),
              ));
            });
            findNearbyFurnitureShops();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black, // background color
            foregroundColor: Colors.white,
          ),
          child: Text('Find Nearby Furniture Shops'),
        )
      ],
    );
  }
}
