import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> savePlacesToFirebase() async {
  final CollectionReference ref =
      FirebaseFirestore.instance.collection("myAppCollection");
  for (final Place place in listOfPlace) {
    final String id =
        DateTime.now().toIso8601String() + Random().nextInt(1000).toString();
    ref.doc("das");

    await ref.doc(id).set(place.toMap());
  }
}

class Place {
  final String title;
  final bool isActive;
  final String image;
  final double rating;
  final String date;
  final int price;
  final String address;
  final String vendor;
  final String vendorProfession;
  final String vendorProfile;
  final int review;
  final String bedAndBathroom;
  final int yearOfHosting;
  final double latitude;
  final double longitude;
  final List<String> imageUrls;

  const Place({
    required this.title,
    required this.address,
    required this.bedAndBathroom,
    required this.date,
    required this.image,
    required this.imageUrls,
    required this.isActive,
    required this.latitude,
    required this.longitude,
    required this.price,
    required this.rating,
    required this.review,
    required this.vendor,
    required this.vendorProfession,
    required this.vendorProfile,
    required this.yearOfHosting,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'isActive': isActive,
      'image': image,
      'rating': rating,
      'date': date,
      'price': price,
      'address': address,
      'vendor': vendor,
      'vendorProfession': vendorProfession,
      'vendorProfile': vendorProfile,
      'yearOfHostin': yearOfHosting,
      'bedAndBathroom': bedAndBathroom,
      'latitude': latitude,
      'longitude': longitude,
      'imageUrls': imageUrls,
      'review': review,
    };
  }
}

final List<Place> listOfPlace = [
  const Place(
    title: 'Nice small bedroom in a nice small house',
    address: 'Mosscow - Russia"',
    bedAndBathroom: " 1 bed . Shared bathroom",
    date: "Now 11-6",
    image:
        "https://images.pexels.com/photos/53464/sheraton-palace-hotel-lobby-architecture-san-francisco-53464.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    imageUrls: [
      "https://images.pexels.com/photos/53464/sheraton-palace-hotel-lobby-architecture-san-francisco-53464.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
      "https://images.pexels.com/photos/591383/pexels-photo-591383.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
      "https://images.pexels.com/photos/2291624/pexels-photo-2291624.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
      "https://images.pexels.com/photos/1001965/pexels-photo-1001965.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
    ],
    isActive: true,
    latitude: 55.7558,
    longitude: 37.6173,
    price: 38,
    rating: 4.85,
    review: 126,
    vendor: "Mike Tyson",
    vendorProfession: "Boxer",
    vendorProfile:
        'https://tse4.mm.bing.net/th?id=OIP.7hxNJJXMVvJb8lnK0IEBPQHaLH&w=853&h=1280&rs=1&pid=ImgDetMain',
    yearOfHosting: 5,
  ),
  const Place(
    title: 'Cosy room in fabulous condo!',
    address: 'Beijing - China',
    bedAndBathroom: " 1 double bed . Shared bathroom",
    date: "Oct 01-06",
    image:
        "https://toplist.vn/images/800px/khach-san-golden-lotus-luxury-362428.jpg",
    imageUrls: [
      "https://toplist.vn/images/800px/khach-san-golden-lotus-luxury-362428.jpg",
      "https://images.pexels.com/photos/261388/pexels-photo-261388.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
      "https://images.pexels.com/photos/2467558/pexels-photo-2467558.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
      "https://images.pexels.com/photos/2869215/pexels-photo-2869215.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
    ],
    isActive: true,
    latitude: 39.9042,
    longitude: 116.4074,
    price: 32,
    rating: 4.7,
    review: 113,
    vendor: "Pham Thoai",
    vendorProfession: "TikToker",
    vendorProfile: 'https://randomuser.me/api/portraits/men/33.jpg',
    yearOfHosting: 3,
  ),
  const Place(
    title: 'Connect with your heart to this magical place',
    address: 'Jakarta - Indonesia',
    bedAndBathroom: " 2 bed . 2 bathroom",
    date: "May 23-26",
    image:
        "https://images.pexels.com/photos/164595/pexels-photo-164595.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    imageUrls: [
      "https://images.pexels.com/photos/164595/pexels-photo-164595.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
      "https://images.pexels.com/photos/2096983/pexels-photo-2096983.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
      "https://images.pexels.com/photos/594077/pexels-photo-594077.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
      "https://images.pexels.com/photos/1755288/pexels-photo-1755288.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
    ],
    isActive: true,
    latitude: 6.2088,
    longitude: 106.8456,
    price: 68,
    rating: 4.5,
    review: 178,
    vendor: "Son Tung",
    vendorProfession: "Singer",
    vendorProfile: "https://randomuser.me/api/portraits/men/30.jpg",
    yearOfHosting: 6,
  ),
  const Place(
    title: 'The Queen\'s Chamber',
    address: 'Astana - Kazakhstan"',
    bedAndBathroom: " 1 bed . 1 bathroom",
    date: "Jan 26-29",
    image:
        "https://cdn.pixabay.com/photo/2015/09/17/10/51/sirmione-943906_1280.jpg",
    imageUrls: [
      "https://cdn.pixabay.com/photo/2015/09/17/10/51/sirmione-943906_1280.jpg",
      "https://images.pexels.com/photos/1838554/pexels-photo-1838554.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
      "https://images.pexels.com/photos/70441/pexels-photo-70441.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
      "https://images.pexels.com/photos/17926439/pexels-photo-17926439/free-photo-of-follow-me-on-insta-for-more-https-www-instagram-com-mikita-yo.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
    ],
    isActive: true,
    latitude: 51.1605,
    longitude: 71.4704,
    price: 59,
    rating: 4.7,
    review: 86,
    vendor: "Jack",
    vendorProfession: "Developer",
    vendorProfile: "https://randomuser.me/api/portraits/men/40.jpg",
    yearOfHosting: 2,
  ),
  const Place(
    title: 'The Love Room',
    address: 'Manila - Philippines',
    bedAndBathroom: " 2 bed . 2 bathroom",
    date: "September 5 - 9",
    image:
        "https://images.pexels.com/photos/2883048/pexels-photo-2883048.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    imageUrls: [
      "https://images.pexels.com/photos/2883048/pexels-photo-2883048.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
      "https://images.pexels.com/photos/338504/pexels-photo-338504.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
      "https://images.pexels.com/photos/1697076/pexels-photo-1697076.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
      "https://images.pexels.com/photos/17926430/pexels-photo-17926430/free-photo-of-follow-me-on-insta-for-more-https-www-instagram-com-mikita-yo.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
    ],
    isActive: true,
    latitude: 14.5995,
    longitude: 120.9842,
    price: 98,
    rating: 5.0,
    review: 76,
    vendor: "Dieu Huyen",
    vendorProfession: "Rapper",
    vendorProfile:
        'https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    yearOfHosting: 4,
  ),
  const Place(
    title: 'Our dream room',
    address: 'Tay Ho - Ha Noi',
    bedAndBathroom: " 4 bed .2  bathroom",
    date: "July 5-8",
    image:
        "https://images.pexels.com/photos/2057610/pexels-photo-2057610.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    imageUrls: [
      "https://images.pexels.com/photos/2057610/pexels-photo-2057610.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
      "https://images.pexels.com/photos/3201921/pexels-photo-3201921.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
      "https://images.pexels.com/photos/2670273/pexels-photo-2670273.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
      "https://images.pexels.com/photos/2382283/pexels-photo-2382283.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
    ],
    isActive: true,
    latitude: 21.0639,
    longitude: 105.8364,
    price: 138,
    rating: 4.9,
    review: 76,
    vendor: "Hao Nam",
    vendorProfession: "Gangster",
    vendorProfile: "https://randomuser.me/api/portraits/men/23.jpg",
    yearOfHosting: 8,
  ),
];
