import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking/components/location_map.dart';
import 'package:hotel_booking/components/my_icon_button.dart';
import 'package:hotel_booking/components/star_rating.dart';
import 'package:hotel_booking/controller/favorite_provider.dart';
import 'package:hotel_booking/controller/trip_provider.dart';

class PlaceDetailScreen extends StatefulWidget {
  final DocumentSnapshot<Object?> place;
  const PlaceDetailScreen({super.key, required this.place});

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  int currenIntdex = 0;
  @override
  Widget build(BuildContext context) {
    final providerRoom = TripProvider.of(context);

    Size size = MediaQuery.of(context).size;
    final provider = FavoriteProvider.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //detail image, back button, share and favorite
              detailImageAndIcon(size, context, provider),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 22.0, vertical: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.place['title'],
                      maxLines: 2,
                      style: const TextStyle(
                          fontSize: 22.0,
                          height: 1.1,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Text(
                      'Room in ${widget.place['address']}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16.0),
                    ),
                    Text(
                      widget.place['bedAndBathroom'],
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 15.0),
                    ),
                  ],
                ),
              ),
              widget.place['isActive'] == true
                  ? ratingAndStarTrue()
                  : ratingAndStarFalse(),
              SizedBox(
                height: size.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    placePropertyList(
                      size,
                      'https://th.bing.com/th/id/OIP.Zbz1rqwQ6ysbvh8Af5XSjwHaHO?w=217&h=212&c=7&r=0&o=5&dpr=2&pid=1.7',
                      '${widget.place['title']}',
                      "${widget.place['vendor']}'s place is uaually fully booked",
                    ),
                    const Divider(),
                    placePropertyList(
                      size,
                      widget.place['vendorProfile'],
                      'Stay with ${widget.place['vendor']}',
                      "${widget.place['vendor']}'s place is uaually fully booked",
                    ),
                    const Divider(),
                    placePropertyList(
                      size,
                      'https://cdn-icons-png.flaticon.com/512/6192/6192020.png',
                      'Room in a rental unit',
                      "Your own room in a home, pluse access\nto shared spaces.",
                    ),
                    const Divider(),
                    placePropertyList(
                      size,
                      'https://thumbs.dreamstime.com/z/meeting-two-working-man-business-people-icon-simple-line-flat-illustration-110629384.jpg',
                      'Shared common spaces',
                      "You'll share parts of the home with the host.",
                    ),
                    const Divider(),
                    placePropertyList(
                      size,
                      'https://th.bing.com/th/id/OIP.ZZeUkUCxaXfe7UjdkOqkhAHaHa?pid=ImgDet&w=202&h=202&c=7&dpr=2',
                      'Shared bathroom',
                      "You'll share the bathroom with others.",
                    ),
                    const Divider(),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    const Text(
                      'About this place',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo.'),
                    const Divider(),
                    const Text(
                      'Where you\'ll be',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${widget.place['address']}',
                      style: const TextStyle(fontSize: 18.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 65.0),
                      child: SizedBox(
                        height: 380,
                        width: size.width,
                        child: LocationMap(
                          place: widget.place,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomSheet: widget.place['isActive'] == true
            ? Container(
                height: size.height * 0.09,
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "\$${widget.place['price']}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                            children: const [
                              TextSpan(
                                text: "night",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        Text(
                          widget.place['date'],
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        )
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor:
                                  providerRoom.isExist(widget.place)
                                      ? Colors.greenAccent
                                      : Colors.deepOrangeAccent.shade100,
                              title: Text(providerRoom.isExist(widget.place)
                                  ? 'Booking Successful  ✅'
                                  : 'Cancelled your booking  ❌'),
                              content: providerRoom.isExist(widget.place)
                                  ? const Text(
                                      'You have successfully booked a room,\n'
                                      'lease quickly go to the hotel check in\n'
                                      'check in as soon as possible.\n'
                                      'We sincerely thank you !.',
                                    )
                                  : const Text(
                                      'If there is any problem with you or there  ,\n'
                                      'is anything at the hotel that makes,\n'
                                      'you unhappy please contact us for support,\n'
                                      'we sincerely thank you !.',
                                    ),
                              actions: <Widget>[
                                TextButton(
                                  style: TextButton.styleFrom(
                                    
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .labelLarge),
                                  child: const Text('Continue'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                        providerRoom.toogleRoom(widget.place);
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32.0, vertical: 13.0),
                          backgroundColor: providerRoom.isExist(widget.place)
                              ? Colors.blueGrey.shade400
                              : Colors.redAccent.shade400),
                      child: Text(
                        providerRoom.isExist(widget.place)
                            ? 'Booked ✅'
                            : 'Reserve',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              )
            : Container(
                decoration: const BoxDecoration(color: Colors.black38),
                alignment: Alignment.center,
                height: 55,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.warning_amber_outlined,
                      size: 28,
                      color: Colors.amber[600],
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    const Text(
                      'Room is full, please find another room !',
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
      ),
    );
  }

  // Container priceAndReserve(Size size) {
  //   return Container(
  //     height: size.height * 0.09,
  //     padding: const EdgeInsets.symmetric(horizontal: 15.0),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       border: Border.all(color: Colors.black12),
  //     ),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             RichText(
  //               text: TextSpan(
  //                 text: "\$${widget.place['price']}",
  //                 style: const TextStyle(
  //                   fontWeight: FontWeight.bold,
  //                   color: Colors.black,
  //                   fontSize: 16.0,
  //                 ),
  //                 children: const [
  //                   TextSpan(
  //                     text: "night",
  //                     style: TextStyle(
  //                       fontSize: 16.0,
  //                       color: Colors.black,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //             Text(
  //               widget.place['date'],
  //               style: const TextStyle(
  //                 fontSize: 15.0,
  //                 fontWeight: FontWeight.bold,
  //                 decoration: TextDecoration.underline,
  //               ),
  //             )
  //           ],
  //         ),
  //         ElevatedButton(
  //           onPressed: () {},
  //           style: ElevatedButton.styleFrom(
  //               shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(15.0)),
  //               padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 13.0),
  //               backgroundColor: Colors.redAccent.shade400),
  //           child: const Text(
  //             'Reserve',
  //             style: TextStyle(
  //                 color: Colors.white,
  //                 fontSize: 18.0,
  //                 fontWeight: FontWeight.bold),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Padding placePropertyList(Size size, image, title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(image),
            radius: 28.0,
          ),
          SizedBox(
            width: size.width * 0.05,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 17.0, fontWeight: FontWeight.w700),
              ),
              Text(
                subtitle,
                softWrap: true,
                overflow: TextOverflow.visible,
                style: TextStyle(
                    fontSize: size.width * 0.0336, color: Colors.grey.shade700),
              )
            ],
          ))
        ],
      ),
    );
  }

  Padding ratingAndStarFalse() => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Row(
          children: [
            const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            Text(
              ' ${widget.place['rating']} . '.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            Text(
              '${widget.place['review']} Review',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  wordSpacing: -2,
                  decoration: TextDecoration.underline),
            )
          ],
        ),
      );

  Container ratingAndStarTrue() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 3.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 14.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                widget.place['rating'].toString(),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, height: 1.0, fontSize: 15.0),
              ),
              StarRating(rating: widget.place['rating'])
            ],
          ),
          Stack(
            children: [
              Image.asset(
                'asset/images/paddy.png',
                fit: BoxFit.cover,
                height: 45.0,
                width: 120,
              ),
              const Positioned(
                left: 38.5,
                top: 4.0,
                child: Text(
                  'Guest\nFavorite',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                widget.place['review'].toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
              const Text(
                'Reviews',
                style: TextStyle(
                    height: 1.3,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline),
              )
            ],
          )
        ],
      ),
    );
  }

  Stack detailImageAndIcon(Size size, BuildContext context, provider) {
    return Stack(
      children: [
        SizedBox(
          height: size.height * 0.30,
          width: double.infinity,
          child: AnotherCarousel(
            images: widget.place['imageUrls']
                .map((url) => Image.network(
                      url,
                      fit: BoxFit.cover,
                    ))
                .toList(),
            showIndicator: false,
            dotBgColor: Colors.transparent,
            onImageChange: (p0, p1) {
              setState(() {
                currenIntdex = p1;
              });
            },
            autoplay: true,
            boxFit: BoxFit.contain,
          ),
        ),
        Positioned(
          right: 3.0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.black,
            ),
            child: Text(
              "${currenIntdex + 1} / ${widget.place['imageUrls'].length}",
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
        Positioned(
          right: 0,
          left: 0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const MyIconButton(icon: Icons.arrow_back_ios_new),
                ),
                SizedBox(
                  width: size.width * 0.55,
                ),
                const MyIconButton(icon: Icons.share_outlined),
                const SizedBox(
                  width: 15.0,
                ),
                //after this all let's make favorite button function by using provider
                InkWell(
                  onTap: () {
                    provider.toggleFavorite(widget.place);
                  },
                  child: MyIconButton(
                    icon: provider.isExist(widget.place)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    iconColor: provider.isExist(widget.place)
                        ? Colors.red
                        : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
