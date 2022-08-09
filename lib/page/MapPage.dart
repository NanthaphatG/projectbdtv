import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:projectbuddytravel/class/location_service.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<AutocompletePrediction> predictions = [];
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> markers = <Marker>[];

  @override
  void initState() {
    markers.add(_kGooglePlexMarker);
    super.initState();
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(16.2250267, 103.2298629),
    zoom: 14.4746,
  );
  static final Marker _kGooglePlexMarker = Marker(
    markerId: MarkerId('_kGooglePlex'),
    infoWindow: InfoWindow(title: 'Google Plex'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(16.2250267, 103.2298629),
  );

  TextEditingController _searchplace = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Maps'),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _searchplace,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(hintText: 'ค้นหาสถานที่'),
                    onChanged: (value) {
                      print(value);
                    },
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    var place = await LocationService().getPlace(_searchplace.text);
                    _gotoPlace(place);
                  },
                  icon: Icon(Icons.search),
                )
              ],
            ),
            Expanded(
              child: GoogleMap(
                mapType: MapType.normal,
                markers: Set<Marker>.of(markers),
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
          ],
        ));
  }

  Future<void> _gotoPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];
    print(lat);
    print(lng);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 14.4746)));
    setMarkers(lat, lng);
  }

  setMarkers(double lat, double lng) {
    markers.clear();
    markers.add(
      Marker(
        markerId: MarkerId("Search"),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: 'New Search'),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    setState(() {});
  }

}
