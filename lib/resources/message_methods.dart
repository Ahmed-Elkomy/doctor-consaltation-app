import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_consult/constants/strings.dart';
import 'package:doc_consult/models/call.dart';

class MessageMethods {
  final CollectionReference messageCollection =
      Firestore.instance.collection(MESSAGES_COLLECTION);

  Stream<DocumentSnapshot> messageStream({String uid}) =>
      messageCollection.document(uid).snapshots();
}
