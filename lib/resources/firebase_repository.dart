import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:doc_consult/models/message.dart';
import 'package:doc_consult/models/user.dart';
import 'package:doc_consult/provider/image_upload_provider.dart';
import 'package:doc_consult/resources/firebase_methods.dart';

import 'package:meta/meta.dart';

class FirebaseRepository {
  FirebaseMethods _firebaseMethods = FirebaseMethods();

  Future<FirebaseUser> getCurrentUser() => _firebaseMethods.getCurrentUser();

  Future<FirebaseUser> signIn() => _firebaseMethods.signIn();

  Future<FirebaseUser> createUserWithEmailAndPassword(
          {String email, String password}) =>
      _firebaseMethods.createUserWithEmailAndPassword(email, password);

  Future<FirebaseUser> authenticateUserWithEmailAndPassword(
          {String email, String password}) =>
      _firebaseMethods.authenticateUserWithEmailAndPassword(email, password);

  Future<User> getUserDetails() => _firebaseMethods.getUserDetails();

  Future<bool> authenticateUser(FirebaseUser user) =>
      _firebaseMethods.authenticateUser(user);

  Future<void> addDataToDb(FirebaseUser user, String username) =>
      _firebaseMethods.addDataToDb(user, username);

  ///responsible for signing out
  Future<void> signOut() => _firebaseMethods.signOut();

  Future<List<User>> fetchAllUsers(FirebaseUser user) =>
      _firebaseMethods.fetchAllUsers(user);

  Future<void> addMessageToDb(Message message, User sender, User receiver) =>
      _firebaseMethods.addMessageToDb(message, sender, receiver);

  Future<String> uploadImageToStorage(File imageFile) =>
      _firebaseMethods.uploadImageToStorage(imageFile);

  // void showLoading(String receiverId, String senderId) =>
  //     _firebaseMethods.showLoading(receiverId, senderId);

  // void hideLoading(String receiverId, String senderId) =>
  //     _firebaseMethods.hideLoading(receiverId, senderId);

  void uploadImageMsgToDb(String url, String receiverId, String senderId) =>
      _firebaseMethods.setImageMsg(url, receiverId, senderId);

  void uploadImage(
          {@required File image,
          @required String receiverId,
          @required String senderId,
          @required ImageUploadProvider imageUploadProvider}) =>
      _firebaseMethods.uploadImage(
          image, receiverId, senderId, imageUploadProvider);
}
