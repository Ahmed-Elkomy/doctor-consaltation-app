import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_consult/resources/message_methods.dart';
import 'package:doc_consult/screens/chatscreens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doc_consult/models/call.dart';
import 'package:doc_consult/provider/user_provider.dart';
import 'package:doc_consult/resources/call_methods.dart';
import 'package:doc_consult/screens/callscreens/pickup/pickup_screen.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class PickupLayout extends StatelessWidget {
  final Widget scaffold;
  final CallMethods callMethods = CallMethods();
  final MessageMethods messageMethods = MessageMethods();

  PickupLayout({
    @required this.scaffold,
  });

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return (userProvider != null && userProvider.getUser != null)
        ? StreamBuilder<DocumentSnapshot>(
            stream: callMethods.callStream(uid: userProvider.getUser.uid),
            builder: (context, callSnapshot) {
              return StreamBuilder<DocumentSnapshot>(
                stream:
                    messageMethods.messageStream(uid: userProvider.getUser.uid),
                builder: (context, messageSnapshot) {
                  if (callSnapshot.hasData && callSnapshot.data.data != null) {
                    Call call = Call.fromMap(callSnapshot.data.data);

                    if (!call.hasDialled) {
                      if (!call.hasStarted) {
                        FlutterRingtonePlayer.playRingtone();
                      }

                      print("starting ringing");
                      return PickupScreen(call: call);
                    }
                  } else if (messageSnapshot.hasData &&
                      messageSnapshot.data.data != null) {
                    return ChatScreen(receiver: userProvider.getUser);
                  }
                  FlutterRingtonePlayer.stop();
                  return scaffold;
                },
              );
            },
          )
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
