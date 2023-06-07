import 'package:beamcoda_jobs_partners_flutter/data/auth.dart';
import 'package:beamcoda_jobs_partners_flutter/types/msgcompact.dart';
import 'package:beamcoda_jobs_partners_flutter/ui/message/chat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/job.dart';
import '../../data/message.dart';
import '../../utils/constants.dart';
import '../job/item/index.dart';
import '../job/new/index.dart';
import 'item.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  void initState() {
    super.initState();

    final messageProvider = Provider.of<MessageProvider>(context, listen: false);
    messageProvider.contactList.clear();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      String result = await messageProvider.getContactList(context);

      if (result != '') {
        Util.showToast(result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color defaultTextColor = Color.fromRGBO(76, 76, 76, 1.0);
    final messageProvider = Provider.of<MessageProvider>(context);

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 20.0, right: 10.0, top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      onPressed: (){

                      },
                      icon: const Icon(Icons.notifications_active_outlined, color: Colors.blue),
                    )
                )
              ),

              const SizedBox(width: 5.0),

              IconButton(
                onPressed: (){

                },
                icon: const Icon(Icons.note_alt_outlined, color: Colors.blue),
              )
            ],
          ),

          const SizedBox(height: 10.0),

          const Text("Messages", textAlign: TextAlign.start, style: TextStyle(
            color: defaultTextColor,
            fontSize: 36.0,
            fontWeight: FontWeight.w700,
          )),

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: messageProvider.contactList.length,
                itemBuilder: (_, i) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return ChatPage(otherID: messageProvider.contactList[i].otherID, otherName: messageProvider.contactList[i].name);
                        })
                      );
                    },
                    child: MessageItem(
                      key: UniqueKey(),
                      msg: messageProvider.contactList[i],
                    )
                  );
                },
              )
            )
          ),
        ]
      )
    );
  }
}
