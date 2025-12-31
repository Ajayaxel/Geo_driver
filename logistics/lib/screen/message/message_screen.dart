import 'package:flutter/material.dart';
import 'package:logistics/screen/home/home_screen.dart';
import 'package:logistics/screen/message/chat_detail_screen.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 18),
              const HederWidget(),
              const SizedBox(height: 20),
              const Text(
                "Messages",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(child: MessageList()), // The scrollable list
            ],
          ),
        ),
      ),
    );
  }
}

class MessageList extends StatelessWidget {
  const MessageList({super.key});

  @override
  Widget build(BuildContext context) {
    // Data list for cleaner code
    final List<Map<String, String>> chats = [
      {
        "name": "Operations Admin",
        "role": "(Admin)",
        "msg": "Great! Please upload seal photos...",
        "time": "09:18",
        "count": "1",
        "img":
            "https://img.freepik.com/free-photo/3d-illustration-person-with-sunglasses_23-2149436188.jpg",
      },
      {
        "name": "Global Mining Corp",
        "role": "(buyer)",
        "msg": "Perfect. Contact me if you enco....",
        "time": "12/05/2025",
        "count": "2",
        "img":
            "https://img.freepik.com/free-photo/3d-render-little-boy-with-glasses-shirt_1142-51523.jpg",
      },
      {
        "name": "QA Inspector Team",
        "role": "(QA Team)",
        "msg": "Shipment has been assigned to you.",
        "time": "12/05/2025",
        "count": "3",
        "img":
            "https://img.freepik.com/free-photo/3d-illustration-person-with-sunglasses_23-2149436188.jpg",
      },
    ];

    return ListView.separated(
      itemCount: chats.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final chat = chats[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatDetailScreen(
                  name: chat['name']!,
                  role: chat['role']!,
                  imageUrl: chat['img']!,
                ),
              ),
            );
          },
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(chat['img']!),
            ),
            title: RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  TextSpan(text: "${chat['name']} "),
                  TextSpan(
                    text: chat['role'],
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            subtitle: Text(
              chat['msg']!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Color(0xffC49E5D),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    chat['count']!,
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  chat['time']!,
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
