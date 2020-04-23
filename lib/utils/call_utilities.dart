import 'dart:math';

import 'package:doc_consult/constants/strings.dart';
import 'package:doc_consult/screens/chatscreens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:doc_consult/models/call.dart';
import 'package:doc_consult/models/user.dart';
import 'package:doc_consult/resources/call_methods.dart';
import 'package:doc_consult/screens/callscreens/call_screen.dart';
import 'package:doc_consult/utils/utilities.dart';

class CallUtils {
  static final CallMethods callMethods = CallMethods();

  static dial({User from, User to, context, CALL_TYPE callType}) async {
    Call call = Call(
      callerId: from.uid,
      callerName: from.name,
      callerPic: from.profilePhoto,
      receiverId: to.uid,
      receiverName: to.name,
      receiverPic: to.profilePhoto,
      channelId: Random().nextInt(1000).toString(),
      callType: callType,
    );
    if (call.callType == CALL_TYPE.chat) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(receiver: to),
          ));
    } else {
      bool callMade = await callMethods.makeCall(call: call);

      call.hasDialled = true;

      if (callMade) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CallScreen(call: call),
            ));
      }
    }
  }
}
