import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

// to upload data in Firebase
Future<void> saveCategoryItems() async {
  final CollectionReference ref =
      FirebaseFirestore.instance.collection("AppCategory");
  for (final Category category in categoriesList) {
    final String id =
        DateTime.now().toIso8601String() + Random().nextInt(1000).toString();
    ref.doc("das");

    await ref.doc(id).set(category.toMap());
  }
}

class Category {
  final String title;
  final String image;

  const Category({
    required this.title,
    required this.image,
  });

// to upload data in Firebase
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'image': image,
    };
  }
}

final List<Category> categoriesList = [
  const Category(
      title: 'Rooms',
      image: 'https://cdn-icons-png.flaticon.com/512/6192/6192020.png'),
  const Category(
      title: 'Icons',
      image: 'https://cdn-icons-png.flaticon.com/512/734/734315.png'),
  const Category(
      title: 'Surfing',
      image: 'https://static.thenounproject.com/png/384446-200.png'),
  const Category(
      title: 'Design',
      image: 'https://cdn-icons-png.freepik.com/512/48/48781.png'),
  const Category(
      title: 'Amazingviews',
      image: 'https://static.thenounproject.com/png/5027454-200.png'),
  const Category(
      title: 'New',
      image:
          'https://cdn0.iconfinder.com/data/icons/google-material-design-3-0/48/ic_fiber_new_48px-1024.png'),
  const Category(
      title: 'Bed&breakfast',
      image: 'https://static.thenounproject.com/png/249107-200.png'),
  const Category(
      title: 'Houseboats',
      image: 'https://cdn-icons-png.freepik.com/512/98/98527.png'),
];
