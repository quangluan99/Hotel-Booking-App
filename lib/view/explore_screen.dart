import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking/components/display_place.dart';
import 'package:hotel_booking/components/display_total_price.dart';
import 'package:hotel_booking/components/map_with_custom_info_windows.dart';
import 'package:hotel_booking/components/search_bar_and_filter.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
//collection for category
  final CollectionReference categoryCollection =
      FirebaseFirestore.instance.collection("AppCategory");

  int slectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(   
        bottom: false,
        child: Column(
          children: [
            //for search bar and fliter button
            const SearchBarAndFilter(),
            //let's fetch list of category items from firebase.
            listofCategoryItems(size),
            const Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //for swicth button
                    DisplayTotalPrice(),
                    //display the place item
                    DisplayPlace(),
                    //
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      //for google map
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const MapWithCustomInfoWindows(),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> listofCategoryItems(Size size) {
    return StreamBuilder(
      stream: categoryCollection.snapshots(),
      builder: (context, streamSnapshot) {
        if (streamSnapshot.hasData) {
          return Stack(
            children: [
              const Positioned(
                left: 0.0,
                right: 0.0,
                top: 80.0,
                child: Divider(
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                height: size.height * 0.12,
                child: ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          slectedIndex = index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 20.0, right: 20.0, left: 20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 28,
                              width: 35,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.network(
                                streamSnapshot.data!.docs[index]['image'],
                                color: slectedIndex == index
                                    ? Colors.black
                                    : Colors.black38,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              streamSnapshot.data!.docs[index]['title'],
                              style: TextStyle(
                                  fontSize: 13,
                                  color: slectedIndex == index
                                      ? Colors.black
                                      : Colors.black38),
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            Container(
                              height: 3.5,
                              width: 50.0,
                              color: slectedIndex == index
                                  ? Colors.black
                                  : Colors.transparent,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
