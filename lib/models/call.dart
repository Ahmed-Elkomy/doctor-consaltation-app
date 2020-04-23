import 'package:doc_consult/constants/strings.dart';

class Call {
  String callerId;
  String callerName;
  String callerPic;
  String receiverId;
  String receiverName;
  String receiverPic;
  String channelId;
  bool hasDialled;
  bool hasStarted;
  CALL_TYPE callType;

  Call({
    this.callerId,
    this.callerName,
    this.callerPic,
    this.receiverId,
    this.receiverName,
    this.receiverPic,
    this.channelId,
    this.hasDialled,
    this.hasStarted,
    this.callType,
  });

  // to map
  Map<String, dynamic> toMap(Call call) {
    Map<String, dynamic> callMap = Map();
    callMap["caller_id"] = call.callerId;
    callMap["caller_name"] = call.callerName;
    callMap["caller_pic"] = call.callerPic;
    callMap["receiver_id"] = call.receiverId;
    callMap["receiver_name"] = call.receiverName;
    callMap["receiver_pic"] = call.receiverPic;
    callMap["channel_id"] = call.channelId;
    callMap["has_dialled"] = call.hasDialled;
    callMap["has_started"] = call.hasStarted;
    callMap["call_type"] = call.callType.toString();
    return callMap;
  }

  Call.fromMap(Map callMap) {
    this.callerId = callMap["caller_id"];
    this.callerName = callMap["caller_name"];
    this.callerPic = callMap["caller_pic"];
    this.receiverId = callMap["receiver_id"];
    this.receiverName = callMap["receiver_name"];
    this.receiverPic = callMap["receiver_pic"];
    this.channelId = callMap["channel_id"];
    this.hasDialled = callMap["has_dialled"];
    this.hasStarted = callMap["has_started"];
    this.callType = getCallTypeFromString(callMap["call_type"]);
  }
  CALL_TYPE getCallTypeFromString(String callType) {
    if (callType == "CALL_TYPE.chat") {
      return CALL_TYPE.chat;
    } else if (callType == "CALL_TYPE.voice") {
      return CALL_TYPE.voice;
    } else {
      return CALL_TYPE.video;
    }
  }
}
