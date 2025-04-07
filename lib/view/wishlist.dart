import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking/controller/favorite_provider.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    final favoriteItems = provider.favorites;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'Edit',
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                const Text(
                  'Wish Lists',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                favoriteItems.isEmpty
                    ? const Text(
                        'No Favorites items yet',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * 0.65,
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10.0,
                                  crossAxisSpacing: 10.0),
                          itemCount: favoriteItems.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            String favorite = favoriteItems[index];

                            return FutureBuilder(
                              future: FirebaseFirestore.instance
                                  .collection("myAppCollection")
                                  .doc(favorite)
                                  .get(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                }
                                if (!snapshot.hasData ||
                                    snapshot.data == null) {
                                  return const Center(
                                    child: Text('Error loading favorites!'),
                                  );
                                }
                                var favoriteItems = snapshot.data!;
                                return Stack(
                                  children: [
                                    //image of favorite items
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  favoriteItems['image']),
                                              fit: BoxFit.cover)),
                                    ),
                                    //favorite icon in the top right corner
                                    const Positioned(
                                        right: 7.0,
                                        top: 7.0,
                                        child: Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        )),
                                    //title of favorite items
                                    Positioned(
                                        bottom: 7.0,
                                        right: 7.0,
                                        child: Container(
                                          color: Colors.black.withOpacity(0.6),
                                          padding: const EdgeInsets.all(3),
                                          child: Text(
                                            favoriteItems['title'],
                                            softWrap: true,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ))
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
