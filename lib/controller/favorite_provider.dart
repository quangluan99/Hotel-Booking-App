import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteProvider extends ChangeNotifier {
  List<String> _favoriteIds = [];
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<String> get favorites => _favoriteIds;
  FavoriteProvider() {
    loadFavorites();
  }

  //toogle favorites states
  void toogleFavorite(DocumentSnapshot place) async {
    String placeId = place.id;
    if (_favoriteIds.contains(placeId)) {
      _favoriteIds.remove(placeId);
      await _removeFavorite(placeId);
    } else {
      _favoriteIds.add(placeId);
      await _addFavorites(placeId);
    }
    notifyListeners();
  }

  //check if a place is afavorited
  bool isExist(DocumentSnapshot place) {
    return _favoriteIds.contains(place.id);
  }

  //Add favorites items to firestore
  Future<void> _addFavorites(String placeId) async {
    try {
      //create the userFavorite collection and add items as favorites in firestore
      await firebaseFirestore
          .collection("userFavorites")
          .doc(placeId)
          .set({'isFavorite ': true});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //remove favorites item from firestore
  Future<void> _removeFavorite(String placeId) async {
    try {
      //create the userFavorite collection and add items as favorites in firestore
      await firebaseFirestore.collection("userFavorites").doc(placeId).delete();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // load favorites item from firestore 
  Future<void> loadFavorites() async {
    try {
      QuerySnapshot snapshot =
          await firebaseFirestore.collection("userFavorites").get();
      _favoriteIds = snapshot.docs.map((doc) => doc.id).toList();
    } catch (err) {
      debugPrint(err.toString());
    }
  }

//Static method to access the provider from any context
  static FavoriteProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<FavoriteProvider>(
      context,
      listen: listen,
    );
  }
}
