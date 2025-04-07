import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotel_booking/components/my_icon_button.dart';

class MapWithCustomInfoWindows extends StatefulWidget {
  const MapWithCustomInfoWindows({super.key});

  @override
  State<MapWithCustomInfoWindows> createState() =>
      _MapWithCustomInfoWindowsState();
}

class _MapWithCustomInfoWindowsState extends State<MapWithCustomInfoWindows> {
  LatLng myCurrentLocation = const LatLng(21.0285, 105.8342);
  BitmapDescriptor customIcon = BitmapDescriptor.defaultMarker;
  late GoogleMapController googleMapController;
  //first add pakage custom info_window
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  //firebase collection to load latlng of place
  final CollectionReference placeCollection =
      FirebaseFirestore.instance.collection("myAppCollection");
  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  //for custom marker
  Future<void> _loadMarkers() async {
    customIcon = await BitmapDescriptor.asset(
        const ImageConfiguration(), "asset/images/marker.png",
        height: 35, width: 28.0);

    Size size = MediaQuery.of(context).size;

    placeCollection.snapshots().listen((QuerySnapshot streamSnapshort) {
      if (streamSnapshort.docs.isNotEmpty) {
        final List allMarkers = streamSnapshort.docs;
        List<Marker> myMarkers = [];
        for (final marker in allMarkers) {
          final dat = marker.data();
          final data = (dat) as Map;

          myMarkers.add(
            Marker(
                markerId: MarkerId(
                  data['address'],
                ),
                position: LatLng(data['latitude'], data['longitude']),
                onTap: () {
                  _customInfoWindowController.addInfoWindow!(
                    Container(
                      height: size.height * 0.30,
                      width: size.width * 0.75,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height: size.height * 0.203,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(25.0),
                                    topRight: Radius.circular(25.0),
                                  ),
                                  child: AnotherCarousel(
                                    images: data['imageUrls']
                                        .map((url) => NetworkImage(url))
                                        .toList(),
                                    dotSize: 5,
                                    indicatorBgPadding: 5,
                                    dotBgColor: Colors.transparent,
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 10,
                                  left: 14,
                                  right: 14,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0, horizontal: 10.0),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(30.0)),
                                        child: const Text(
                                          "Guest Favorite",
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      const MyIconButton(
                                        icon: Icons.favorite_border,
                                        color: Colors.white,
                                        radius: 13.0,
                                      ),
                                      const SizedBox(
                                        width: 12.0,
                                      ),
                                      InkWell(
                                          onTap: () {
                                            _customInfoWindowController
                                                .hideInfoWindow!();
                                          },
                                          child: const MyIconButton(
                                            icon: Icons.close,
                                            color: Colors.white,
                                            radius: 13.0,
                                          )),
                                    ],
                                  ))
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 3.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      data['address'],
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    const SizedBox(
                                      width: 4.0,
                                    ),
                                    Text(data['rating'].toString()),
                                  ],
                                ),
                                Text(
                                  'stay with ${data['vendor']} . ${data['vendorProfession']}',
                                  style: const TextStyle(
                                      color: Colors.black54, fontSize: 15.0),
                                ),
                                Text(
                                  data['date'],
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black54,
                                  ),
                                ),
                                Text.rich(
                                  TextSpan(
                                      text: '\$${data['price']}',
                                      style: const TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold),
                                      children: const [
                                        TextSpan(
                                            text: ' night',
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                            ))
                                      ]),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    LatLng(
                      data['latitude'],
                      data['longitude'],
                    ),
                  );
                },
                icon: customIcon),
          );
        }
        setState(() {
          markers = myMarkers;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FloatingActionButton.extended(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        onPressed: () {
          showModalBottomSheet(
            clipBehavior: Clip.none,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) {
              return Container(
                color: Colors.white,
                height: size.height * 0.72,
                width: size.width,
                child: Stack(
                  children: [
                    SizedBox(
                      height: size.height * 0.72,
                      child: GoogleMap(
                        initialCameraPosition:
                            CameraPosition(target: myCurrentLocation),
                        onMapCreated: (GoogleMapController controller) {
                          googleMapController = controller;
                          _customInfoWindowController.googleMapController =
                              controller;
                        },
                        onTap: (argument) {
                          _customInfoWindowController.hideInfoWindow!();
                        },
                        onCameraMove: (position) {
                          _customInfoWindowController.onCameraMove!();
                        },
                        markers: markers.toSet(),
                      ),
                    ),
                    CustomInfoWindow(
                      controller: _customInfoWindowController,
                      height: size.height * 0.35,
                      width: size.width * 0.80,
                      offset: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 150.0, vertical: 10.0),
                        child: Container(
                          height: 4.0,
                          width: 40.0,
                          decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
        label: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 13.0),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: const Row(
            children: [
              Text(
                'Map',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                width: 6.0,
              ),
              Icon(
                Icons.map_outlined,
                color: Colors.white,
              )
            ],
          ),
        ));
  }
}
