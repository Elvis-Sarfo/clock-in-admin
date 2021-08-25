import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart' show kIsWeb;

class FirestoreDB {
  static Future<QuerySnapshot> getAll(String? collection) async {
    var db = FirebaseFirestore.instance;
    CollectionReference reference = db.collection(collection!);
    return reference.get();
  }

  static Future<DocumentSnapshot> getDocById(
      String? docId, String? collection) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    return firebaseFirestore.collection(collection!).doc(docId!).get();
  }

  static Future<QuerySnapshot> getDocByField(
      String? collection, String? fieldName, dynamic value) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    return firebaseFirestore
        .collection(collection!)
        .where(fieldName!, isEqualTo: value)
        .get();
  }

  static Future<String> saveFile(
      var file, String? folederPath, String? filename) async {
    var _filename = filename == null
        ? (kIsWeb)
            ? DateTime.now().toString()
            : getFileName(file)
        : filename;
    firebase_storage.Reference reference = firebase_storage
        .FirebaseStorage.instance
        .ref('$folederPath/$_filename');

    firebase_storage.TaskSnapshot storageTaskSnapshot = (!kIsWeb)
        ? await reference.putFile(file)
        : await reference.putBlob(file);
    final String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  static String getFileName(File file) {
    var path = file.path.split('/');
    var name = path.last;
    return name;
  }

  static updateDoc(
      String? collection, String? docId, Map<String, dynamic>? update) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    return firebaseFirestore.collection(collection!).doc(docId).update(update!);
  }

  static setDoc(
      String? collection, String? docId, Map<String, dynamic>? update) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    return firebaseFirestore.collection(collection!).doc(docId).set(update!);
  }

  static Future<DocumentReference> addDoc(
      String? collection, Map<String, dynamic>? data) async {
    return await FirebaseFirestore.instance.collection(collection!).add(data!);
  }

  static Future<String> addDocWithId(
      String? collection, Map<String, dynamic>? data, String? docId) async {
    var _existinfDoc = await FirestoreDB.getDocById(docId!, collection!);
    if (!_existinfDoc.exists) {
      await FirebaseFirestore.instance
          .collection(collection)
          .doc(docId)
          .set(data!);
      return 'saved';
    } else {
      throw ('Doument Id already Exist');
    }
  }

  static Future<void> deleteDoc(String? collection, String? docId) async {
    return await FirebaseFirestore.instance
        .collection(collection!)
        .doc(docId!)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }
}
