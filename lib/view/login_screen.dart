import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel_booking/Authentication/google_authentication.dart';
import 'package:hotel_booking/components/social_icons.dart';
import 'package:hotel_booking/components/phone_number_field.dart';
import 'package:hotel_booking/view/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Log in or sign up',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(
              color: Colors.black12,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome to Viet Nam',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  //for phone number field
                  PhoneNumberField(
                    size: size,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  RichText(
                    text: const TextSpan(
                        text:
                            'We\'ll call or text you to conform your number. Standart messagge and rates apply.  ',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ))
                        ]),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),

                  Container(
                      width: size.width,
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.pink),
                      child: const Center(
                        child: Text(
                          'Continue',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  const Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Divider(
                            color: Colors.black38,
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'or',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Divider(
                            color: Colors.black38,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  InkWell(
                    onTap: () async {
                      await FireBaseAuthSV().singInWithGoogle();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const MainScreen();
                          },
                        ),
                      );
                    },
                    child: SocialIcons(
                      size: size,
                      icon: Icons.facebook,
                      color: Colors.blueAccent,
                      name: 'Continue with Facbook',
                      iconSize: 28.0,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await FireBaseAuthSV().singInWithGoogle();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const MainScreen();
                          },
                        ),
                      );
                    },
                    child: SocialIcons(
                      size: size,
                      icon: FontAwesomeIcons.google,
                      color: Colors.pink,
                      name: 'Continue with Google',
                      iconSize: 28.0,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await FireBaseAuthSV().signInWithApple();
                      if (FireBaseAuthSV().signInWithApple()) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const MainScreen();
                            },
                          ),
                        );
                      }
                    },
                    child: SocialIcons(
                      size: size,
                      icon: Icons.apple,
                      color: Colors.black,
                      name: 'Continue with Apple',
                      iconSize: 28.0,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await FireBaseAuthSV().singInWithGoogle();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const MainScreen();
                          },
                        ),
                      );
                    },
                    child: SocialIcons(
                      size: size,
                      icon: Icons.email,
                      color: Colors.blueAccent,
                      name: 'Continue with Email',
                      iconSize: 28.0,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Center(
                    child: Text(
                      'Need help?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
