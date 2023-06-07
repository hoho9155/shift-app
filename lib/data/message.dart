import 'dart:convert';
import 'package:beamcoda_jobs_partners_flutter/data/auth.dart';
import 'package:beamcoda_jobs_partners_flutter/types/chatitem.dart';
import 'package:beamcoda_jobs_partners_flutter/types/msgcompact.dart';
import 'package:beamcoda_jobs_partners_flutter/ui/message/item.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../types/partner.dart';
import '../types/register_partner.dart';
import '../types/user.dart';
import '../utils/constants.dart';

class MessageProvider extends ChangeNotifier {
  final List<MsgCompact> _contactList = <MsgCompact>[];
  final List<ChatItem> _chatList = <ChatItem>[];

  List<MsgCompact> get contactList => _contactList;
  List<ChatItem> get chatList => _chatList;

  Future<String> getContactList(BuildContext ctx) async {
    AuthProvider provider = Provider.of<AuthProvider>(ctx,listen: false);

    try {
      final Uri uri =
      Uri.parse('${AppConstants.API_URL}${AppConstants.MESSAGE_CONTACTLIST}');
      Map<String, dynamic> obj = { 'isWorker': provider.isWorker};

      if (provider.isWorker) {
        obj['id'] = provider.user?.id;
      }
      else {
        obj['id'] = provider.partner?.id;
      }

      final response = await http.post(uri, body: jsonEncode(obj),
        headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${provider.token}'
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        String result = data['result'];

        if (result != 'success') {
          return result;
        }

        List<dynamic> list = data['list'];

        for (Map<String, dynamic> element in list) {
          _contactList.add(MsgCompact(name: element['name'],
            lastMsg: element['msg'],
            dayAgo: element['date'],
            otherID: provider.isWorker ? element['partnerId'] : element['workerId']
          ));
        }
        notifyListeners();
        return '';
      }
    }catch(_){}

    return AppConstants.MSG_NETERROR;
  }

  Future<String> getChatList(BuildContext ctx, int id) async {
    AuthProvider provider = Provider.of<AuthProvider>(ctx,listen: false);

    try {
      final Uri uri =
      Uri.parse('${AppConstants.API_URL}${AppConstants.MESSAGE_LIST}');
      Map<String, dynamic> obj = {};

      if (provider.isWorker) {
        obj['workerId'] = provider.user?.id;
        obj['partnerId'] = id;
      }
      else {
        obj['partnerId'] = provider.partner?.id;
        obj['workerId'] = id;
      }
      final response = await http.post(uri, body: jsonEncode(obj),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${provider.token}'
          });

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        String result = data['result'];

        if (result != 'success') {
          return result;
        }

        List<dynamic> list = data['list'];

        for (Map<String, dynamic> element in list) {
          _chatList.add(ChatItem(msg: element['msg'],
              date: element['date'],
              isOwner: provider.isWorker == element['sender']));
        }
        notifyListeners();
        return '';
      }
    }catch(_){}

    return AppConstants.MSG_NETERROR;
  }

  Future<String> messageInsert(BuildContext ctx, int id, String msg) async {
    AuthProvider provider = Provider.of<AuthProvider>(ctx, listen: false);

    try {
      final Uri uri =
      Uri.parse('${AppConstants.API_URL}${AppConstants.MESSAGE_CONTACTLIST}');
      Map<String, dynamic> obj = { 'msg': msg, 'sender': provider.isWorker ? 1 : 0};

      if (provider.isWorker) {
        obj['workerId'] = provider.user?.id;
        obj['partnerId'] = id;
      }
      else {
        obj['partnerId'] = provider.partner?.id;
        obj['workerId'] = id;
      }

      final response = await http.post(uri, body: jsonEncode({
        'id': id,
        'msg': msg
      }), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${provider.token}'
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        String result = data['result'];

        if (result != 'success') {
          return result;
        }

        notifyListeners();
        return '';
      }
    }catch(_) {}

    return AppConstants.MSG_NETERROR;
  }
}