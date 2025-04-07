import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking/controller/favorite_provider.dart';
import 'package:hotel_booking/view/place_detail_screen.dart';

class DisplayPlace extends StatefulWidget {
  const DisplayPlace({super.key});

  @override
  State<DisplayPlace> createState() => _DisplayPlaceState();
}

class _DisplayPlaceState extends State<DisplayPlace> {
//collection for place item
  final CollectionReference placeCollection =
      FirebaseFirestore.instance.collection("myAppCollection");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final provider = FavoriteProvider.of(context);
    return StreamBuilder(
      stream: placeCollection.snapshots(),
      builder: (context, streamSnapshot) {
        if (streamSnapshot.hasData) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: streamSnapshot.data!.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final place = streamSnapshot.data!.docs[index];

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return PlaceDetailScreen(place: place);
                      },
                    ));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: SizedBox(
                              height: 278,
                              width: double.infinity,
                              child: AnotherCarousel(
                                images: place['imageUrls']
                                    .map((url) => Image.network(
                                          url,
                                          fit: BoxFit.cover,
                                        ))
                                    .toList(),
                                dotSize: 6.0,
                                animationDuration:
                                    const Duration(milliseconds: 4000),
                                animationCurve: Curves.easeOutExpo,
                                indicatorBgPadding: 5.0,
                                dotBgColor: Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 18.0,
                            right: 15.0,
                            left: 15.0,
                            child: Row(
                              children: [
                                place['isActive'] == true
                                    ? Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(35.0)),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 15.0,
                                            vertical: 5.0,
                                          ),
                                          child: Text(
                                            'Guest Favorite',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox(
                                        width: size.width * 0.03,
                                      ),
                                const Spacer(),
                                //for favorite button

                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    const Icon(
                                      Icons.favorite_outline_rounded,
                                      size: 35.0,
                                      color: Colors.white,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        provider.toogleFavorite(place);
                                      },
                                      child: Icon(
                                        Icons.favorite,
                                        size: 30.0,
                                        color: provider.isExist(place)
                                            ? Colors.red
                                            : Colors.black54,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          //for vendor profile
                          vendorProfile(place),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Row(
                        children: [
                          Text(
                            place['address'],
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
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
                          Text(
                            place['rating'].toString(),
                          ),
                        ],
                      ),
                      Text(
                        'stay with ${place['vendor']} . ${place['vendorProfession']}',
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 15.0),
                      ),
                      Text(
                        place['date'],
                        style: const TextStyle(
                          fontSize: 15.0,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.007,
                      ),
                      RichText(
                          text: TextSpan(
                              text: '\$${place['price']}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 15.0),
                              children: const [
                            TextSpan(
                                text: ' night',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.normal))
                          ])),
                      SizedBox(
                        height: size.height * 0.005,
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }
        {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Positioned vendorProfile(QueryDocumentSnapshot<Object?> place) {
    return Positioned(
      bottom: 10.0,
      left: 10.0,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0)),
        child: Image.network(
          place['vendorProfile'],
          height: 50.0,
          width: 50,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
