import 'package:flutter/material.dart';
import 'package:hotel_booking/components/my_icon_button.dart';
import 'package:hotel_booking/model/message_model.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  List<String> messgaType = ['All', 'Traveling', 'Support'];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Spacer(),
                  MyIconButton(
                    icon: Icons.search,
                    color: Colors.white70,
                    radius: 22.0,
                  ),
                  MyIconButton(
                    icon: Icons.tune,
                    color: Colors.white70,
                    radius: 22.0,
                  ),
                ],
              ),
              const SizedBox(
                height: 5.0,
              ),
              const Text(
                'Message',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: List.generate(
                  messgaType.length,
                  (index) => GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          selectedIndex = index;
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10.0,
                        ),
                        decoration: BoxDecoration(
                            color: selectedIndex == index
                                ? Colors.black
                                : Colors.black12.withOpacity(0.04),
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Text(
                          messgaType[index],
                          style: TextStyle(
                              color: selectedIndex == index
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              ...messages.map((message) => _buildMessageItem(message)),
            ],
          ),
        ),
      )),
    );
  }
}

//Build message item UI
Widget _buildMessageItem(Message message) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 18.0),
    child: Row(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 80,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(message.image), fit: BoxFit.cover),
              ),
            ),
            Positioned(
                bottom: -12.0,
                right: -18,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(message.vendorImage),
                  backgroundColor: Colors.white,
                  radius: 23.0,
                )),
          ],
        ),
        const SizedBox(
          width: 23.0,
        ),
        Flexible(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  message.name,
                  style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  message.date,
                  style: const TextStyle(fontSize: 15.0, color: Colors.black54),
                ),
              ],
            ),
            Text(
              message.description,
              maxLines: 2,
              softWrap: true,
              style: const TextStyle(
                height: 1.0,
                fontSize: 15.0,
                color: Colors.black54,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Icon(Icons.timelapse),
                const SizedBox(
                  width: 5.0,
                ),
                Text(
                  message.duration,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      height: 1.2,
                      fontSize: 15.0,
                      color: Colors.black54,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ],
        ))
      ],
    ),
  );
}
