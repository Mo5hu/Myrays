import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor? pinLocationIcon;
  Set<Marker> _markers = {};
  bool onTapAlert = false;

  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(
              size: Size(0.0001, 1),
            ),
            'assets/map_placeholder.png')
        .then((onValue) {
      pinLocationIcon = onValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Position>(
      builder: (context, Position currentPosition, child) {
        print("Current Position =============> " +
            currentPosition.latitude.toString() +
            currentPosition.longitude.toString());
        return GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
              target:
                  LatLng(currentPosition.latitude, currentPosition.longitude),
              zoom: 10.0),
          markers: _markers,
          onTap: (coord) {
            setState(() {
              _markers.add(Marker(
                  markerId: MarkerId("PlayerUID"),
                  position: coord,
                  icon: pinLocationIcon!,
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return customDialog();
                        });
                  }));
            });
          },
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
        );
      },
    );
  }

  Dialog customDialog() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 20,
                    child: Text(
                      "M",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Munx",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Honda Civic Ek",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "2000 Vti Oriel",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Text(
                  "The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog."),
            ),
            ListTile(
              title: Text(
                "Add to Friend's List",
                style: TextStyle(fontSize: 16),
              ),
              leading: Icon(Icons.person_add),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                "Invite to Voice Chat",
                style: TextStyle(fontSize: 16),
              ),
              leading: Icon(Icons.call),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                "Invite For a Race",
                style: TextStyle(fontSize: 16),
              ),
              leading: Icon(Icons.clear_all),
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
