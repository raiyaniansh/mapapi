import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapapi/screen/home/cantroller/home_cantroller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeCantroller homeCantroller = Get.put(HomeCantroller());

  @override
  void initState() {
    super.initState();
    homeCantroller.mapLatLon();
  }

  @override
  void _onCameraMove(CameraPosition position) {
    homeCantroller.lastMapPosition = position.target;
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      homeCantroller.markers.add(Marker(
        markerId: MarkerId(homeCantroller.lastMapPosition.toString()),
        position: homeCantroller.lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: 750,
              child: Obx(
                () => GoogleMap(
                  onMapCreated: homeCantroller.onMapCreated,
                  initialCameraPosition: homeCantroller.cameraps.value,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  trafficEnabled: homeCantroller.traffic.value,
                  mapType: homeCantroller.Map.value,
                  markers: homeCantroller.markers,
                  onCameraMove: _onCameraMove,
                  onLongPress: (argument) async {
                    homeCantroller.placelist.value =
                        await placemarkFromCoordinates(
                            argument.latitude, argument.longitude);
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                        color: Colors.grey.shade800,
                        child: Column(
                          children: [
                            Text("Latitude : ${homeCantroller.lat}",
                                style: TextStyle(color: Colors.white)),
                            Text("Longitude : ${homeCantroller.lon}",
                                style: TextStyle(color: Colors.white)),
                            Text("${homeCantroller.placelist[0]}",
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Align(alignment: Alignment.bottomCenter,child: Container(
              height: 50,
              width: double.infinity,
              child: Row(
                children: [
                  SizedBox(width: 25,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.home_work_outlined,size: 25,color: Colors.black54),
                      Text("Home")
                    ],
                  ),
                  Expanded(child: SizedBox(width: 15,)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on_outlined,size: 25,color: Colors.black54),
                      Text("Location")
                    ],
                  ),
                  Expanded(child: SizedBox(width: 15,)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.bookmark_border,size: 25,color: Colors.black54),
                      Text("Save")
                    ],
                  ),
                  SizedBox(width: 25,),
                ],
              ),
            )),
            Positioned(
              top: 10,
              left: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 290,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12, spreadRadius: 1, blurRadius: 1)
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.location_on,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Search here",
                          style: TextStyle(color: Colors.black54, fontSize: 18),
                        ),
                        Expanded(
                            child: SizedBox(
                          width: 5,
                        )),
                        Icon(
                          Icons.mic,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(25),boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 1,spreadRadius: 1)]),child: Row(children: [Icon(Icons.restaurant,color: Colors.black54,size: 18),SizedBox(width: 5,),Text("Restaurant")]),),
                        SizedBox(width: 10,),
                        Container(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(25),boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 1,spreadRadius: 1)]),child: Row(children: [Icon(Icons.shopping_bag_outlined,color: Colors.black54,size: 18),SizedBox(width: 5,),Text("Shopping")]),),
                        SizedBox(width: 10,),
                        Container(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(25),boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 1,spreadRadius: 1)]),child: Row(children: [Icon(Icons.hotel_outlined,color: Colors.black54,size: 18),SizedBox(width: 5,),Text("Hotel")]),),
                        SizedBox(width: 10,),
                        Container(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(25),boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 1,spreadRadius: 1)]),child: Row(children: [Icon(Icons.local_hospital_outlined,color: Colors.black54,size: 18),SizedBox(width: 5,),Text("Hospital")]),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 10,
              top: 150,
              child: InkWell(
                  onTap: () {
                    _onAddMarkerButtonPressed();
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade800, shape: BoxShape.circle),
                    child:
                        Icon(Icons.location_on_outlined, color: Colors.white),
                  )),
            ),
            Positioned(
              right: 10,
              top: 100,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                      color: Colors.grey.shade800,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Map type",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  homeCantroller.changeMap(MapType.normal);
                                  Get.back();
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                'https://www.google.com/maps/d/thumbnail?mid=1VVzVQilyjoopnF9rH2HGUcuOvq8')),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Normal",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  homeCantroller.changeMap(MapType.satellite);
                                  Get.back();
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                'http://4.bp.blogspot.com/_wZTCU0dAc5k/S-VfXawH6ZI/AAAAAAAAAEE/vDqEFXMcPes/s1600/google+earth-driver.JPG'),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Satellite",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  homeCantroller.changeMap(MapType.terrain);
                                  Get.back();
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                'https://maps.gstatic.com/tactile/layerswitcher/ic_terrain-2x.png'),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Terrain",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                          SizedBox(height: 25,),
                          Text(
                            "Map details",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              homeCantroller.changetraffice();
                              Get.back();
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            'https://tse3.mm.bing.net/th?id=OIP.DX5OHNmy_b8M2AsOz7fhyAAAAA&pid=Api&P=0'),fit: BoxFit.cover),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Traffice",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade800, shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.layers_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
