import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState(); // Change _MapScreenState to MapScreenState
}

class MapScreenState extends State<MapScreen> {  // Change _MapScreenState to MapScreenState
  late GoogleMapController mapController;
  LatLng _center = const LatLng(45.521563, -122.677433); // Example: Portland, OR
  late Marker _marker;

  @override
  void initState() {
    super.initState();
    _marker = Marker(
      markerId: MarkerId('current_location'),
      position: _center,
      infoWindow: InfoWindow(title: 'Your Location'),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void dispose() {
    mapController.dispose(); // Dispose of the controller when the widget is disposed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Google Maps')),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
        markers: {_marker},
      ),
    );
  }
}
