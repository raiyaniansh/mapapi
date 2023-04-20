import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeCantroller extends GetxController
{
  RxDouble lat = 0.0.obs;
  RxDouble lon = 0.0.obs;
  Rx<CameraPosition> cameraps= CameraPosition(target: LatLng(21.0000,78.0000),zoom: 3).obs;
  Completer<GoogleMapController> _controller = Completer();

  Rx<MapType> Map = MapType.normal.obs;

  RxBool traffic=false.obs;

  RxList<Placemark> placelist = <Placemark>[].obs;

  final Set<Marker> markers = {};
  static const LatLng _center = const LatLng(21.2137795, 72.0000);
  LatLng lastMapPosition = _center;

  void changeMap(MapType map)
  {
    Map.value=map;
    print(Map);
  }

  Future mapLatLon()
  async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    lat.value=position.latitude;
    lon.value=position.longitude;

    changeCamera();
  }

  void changeCamera()
  {
    cameraps.value = CameraPosition(target: LatLng(21.0000,78.0000),zoom: 11);
  }

  void changetraffice()
  {
    traffic.value=!traffic.value;
  }

  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

}