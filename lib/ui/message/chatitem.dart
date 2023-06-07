import 'package:beamcoda_jobs_partners_flutter/types/msgcompact.dart';
import 'package:flutter/material.dart';
import '../../types/chatitem.dart';

class ChatItemPage extends StatelessWidget {
  const ChatItemPage({required Key key, required this.chatItem}) : super(key: key);
  final ChatItem chatItem;

  @override
  Widget build(BuildContext context) {
    const Color defaultTextColor = Color.fromRGBO(76, 76, 76, 1.0);
    double screenWidth = MediaQuery.of(context).size.width;

    return Align(
      alignment: chatItem.isOwner ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: screenWidth / 2),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10.0)
        ),
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        margin: const EdgeInsets.only(bottom: 5.0),
        child: Column(
          crossAxisAlignment: chatItem.isOwner ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(chatItem.msg, style: const TextStyle(color: defaultTextColor, fontSize: 18.0, fontWeight: FontWeight.w500)),

            const SizedBox(height: 5.0),

            Text(chatItem.date, style: const TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.w400))
          ],
        )
      )
    );
  }
}