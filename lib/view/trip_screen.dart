import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking/controller/trip_provider.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({super.key});

  @override
  State<TripScreen> createState() => _WishlistState();
}

class _WishlistState extends State<TripScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = TripProvider.of(context);
    final roomReservation = provider.room;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25.0,
                ),
                const Text(
                  'Trip booked',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                roomReservation.isEmpty
                    ? const Text(
                        'No trips here !',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : const Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          'Edit',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 25.0,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                    ),
                    itemCount: roomReservation.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      String room = roomReservation[index];
                      return _buildRoomItem(room);
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

  Widget _buildRoomItem(String room) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance
          .collection("RoomReservation")
          .doc(room)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(
            child: Text('Error loading favorites!'),
          );
        }
        var rooms = snapshot.data!;
        return Stack(
          children: [
            // Image of room
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                  image: NetworkImage(rooms['image']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Status in the top right corner
            Positioned(
              right: -5,
              top: -8.0,
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {},
                child: const Text(
                  'Booked ✅',
                ),
              ),
            ),
            // Title of room
            Positioned(
              bottom: 7.0,
              right: 7.0,
              child: Container(
                color: Colors.black.withOpacity(0.6),
                padding: const EdgeInsets.all(3),
                child: Text(
                  rooms['address'],
                  softWrap: true,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
