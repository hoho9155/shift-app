import 'package:beamcoda_jobs_partners_flutter/ui/message/chatitem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../data/message.dart';
import '../../types/chatitem.dart';
import '../../utils/constants.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.otherID, required this.otherName});
  final int otherID;
  final String otherName;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool canSend = false;
  String msg = '';

  @override
  void initState() {
    super.initState();

    final messageProvider = Provider.of<MessageProvider>(context, listen: false);
    messageProvider.chatList.clear();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      String result = await messageProvider.getChatList(context, widget.otherID);

      if (result != '') {
        Util.showToast(result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    const Color defaultTextColor = Color.fromRGBO(76, 76, 76, 1.0);
    final messageProvider = Provider.of<MessageProvider>(context);

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Colors.grey, width: 1.0))
              ),
              child: Row(
                children: [
                  IconButton(
                    color: Colors.blue,
                    iconSize: 30.0,
                    padding: const EdgeInsets.all(0),
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    }),

                  const SizedBox(width: 20.0),

                  Text(widget.otherName, style: const TextStyle(color: defaultTextColor, fontSize: 24.0, fontWeight: FontWeight.w700))
                ]
              ),
            ),

            Expanded(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: messageProvider.chatList.length,
                    itemBuilder: (context, index) {
                      return ChatItemPage(key: UniqueKey(), chatItem: messageProvider.chatList[index]);
                    }
                  )
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
              child: Stack(
                children: [
                  TextField(
                    style: const TextStyle(color: defaultTextColor, fontSize: 18.0),
                    maxLines: null,
                    decoration: InputDecoration(
                      fillColor: Colors.white54,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0), borderSide: const BorderSide(color: Colors.grey, width: 1.0)),
                      hintText: "Write a message..."
                    ),
                    onChanged: (value) {
                      msg = value;

                      if (canSend != value.isNotEmpty) {
                        setState(() {
                          canSend = value.isNotEmpty;
                        });
                      }
                    },
                  ),

                  if (canSend)
                    Positioned(
                      right: 10,
                      top: 10,
                      child: ElevatedButton(
                        onPressed: () {
                          if (msg != '') {
                            messageProvider.messageInsert(context, widget.otherID, msg);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          elevation: 0,
                          textStyle: const TextStyle(fontSize: 18.0),
                          padding: const EdgeInsets.all(15.0),
                          shape: const StadiumBorder()
                        ),
                        child: const Text("Send"),
                      )
                    )
                ],
              )
            )
          ]
        ),
      )
    );
  }
}