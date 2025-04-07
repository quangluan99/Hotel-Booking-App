import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TripProvider extends ChangeNotifier {
  List<String> _roomReservation = [];
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<String> get room => _roomReservation;
  TripProvider() {
    loadRoom();
  }

  void toogleRoom(DocumentSnapshot place) async {
    String placeId = place.id;
    if (_roomReservation.contains(placeId)) {
      _roomReservation.remove(placeId);
      await _removeRoom(placeId);
    } else {
      _roomReservation.add(placeId);
      await _addRoom(placeId, place);
    }
    notifyListeners();
  }

  Future<void> _addRoom(String placeId, DocumentSnapshot place) async {
    try {
      await firebaseFirestore.collection("RoomReservation").doc(placeId).set({
        '${place['address']}': true,
        'address': '${place['address']}',
        'image': '${place['image']}'
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  bool isExist(DocumentSnapshot place) {
    return _roomReservation.contains(place.id);
  }

  Future<void> _removeRoom(String placeId) async {
    try {
      await firebaseFirestore
          .collection("RoomReservation")
          .doc(placeId)
          .delete();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> loadRoom() async {
    try {
      QuerySnapshot snapshot =
          await firebaseFirestore.collection("RoomReservation").get();
      _roomReservation = snapshot.docs.map((doc) => doc.id).toList();
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  static TripProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<TripProvider>(
      context,
      listen: listen,
    );
  }
}
