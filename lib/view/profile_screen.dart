import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text(
                        'Profile',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28.0,
                        ),
                      ),
                      Icon(
                        Icons.notifications_outlined,
                        size: 32.0,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 33.0,
                        backgroundColor: Colors.black54,
                        backgroundImage: NetworkImage(
                            "${FirebaseAuth.instance.currentUser!.photoURL}"),
                      ),
                      SizedBox(
                        width: size.height * 0.02,
                      ),
                      Text.rich(
                        TextSpan(
                            text:
                                "${FirebaseAuth.instance.currentUser!.displayName}\n",
                            style: const TextStyle(
                              fontSize: 18.0,
                            ),
                            children: const [
                              TextSpan(
                                  text: 'Show profile',
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.black54))
                            ]),
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Divider(
                    color: Colors.black26,
                  ),
                  Card(
                    elevation: 4.5,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                      child: Row(
                        children: [
                          const Text.rich(
                            TextSpan(
                                text: "Airbnb your place\n",
                                style: TextStyle(
                                    height: 2.0,
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                    text:
                                        'It\'s simple to get set up and \nstart earning.',
                                    style: TextStyle(
                                      height: 1.1,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ]),
                          ),
                          const Spacer(),
                          Image.network(
                            "https://th.bing.com/th/id/OIP.epXepamLKkmmw82lnwVeAAHaHa?w=626&h=626&rs=1&pid=ImgDetMain",
                            height: 130.0,
                            width: 130.0,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  const Divider(
                    color: Colors.black12,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'Settings',
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  profileInfo(Icons.person_outline, 'Personal information'),
                  profileInfo(Icons.security, 'Login & security'),
                  profileInfo(Icons.settings_outlined, 'Accessibility'),
                  profileInfo(Icons.note_outlined, 'Taxes'),
                  profileInfo(Icons.person_2_outlined, 'Personal information'),
                  profileInfo(Icons.translate, 'Translation'),
                  profileInfo(Icons.notifications_outlined, 'Notifications'),
                  profileInfo(Icons.looks_outlined, 'Privacy and sharing'),
                  profileInfo(Icons.card_travel, 'Travel for work'),
                ],
              ),
            ),
          )),
    );
  }

  Padding profileInfo(IconData icon, name) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 32.0,
                color: Colors.black.withOpacity(0.7),
              ),
              const SizedBox(
                width: 18.0,
              ),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
          const SizedBox(
            height: 7.0,
          ),
          const Divider(
            color: Colors.black12,
          ),
        ],
      ),
    );
  }
}
