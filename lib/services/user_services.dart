// import 'dart:async';
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:farmasyst_mobile/model/farm.dart';
// import 'package:farmasyst_mobile/model/product.dart';
// import 'package:farmasyst_mobile/services/sharedPrefs.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';

// class UserServices {
//   static Future<void> saveUserInfo(
//       String collectionName, String id, dynamic data) async {
//     FirebaseFirestore.instance
//         .collection(collectionName)
//         .doc(id)
//         .set(data.toMap());
//   }

//   static Future<DocumentReference> saveFarm(Farm farms) async {
//     return await FirebaseFirestore.instance
//         .collection("Farms")
//         .add(farms.toMap());
//   }

//   static Future<DocumentReference> saveProduct(Product products) async {
//     return await FirebaseFirestore.instance
//         .collection("Products")
//         .add(products.toMap());
//   }

//   static Future<DocumentSnapshot> getDocument(String collection, String docId) {
//     return FirebaseFirestore.instance.collection('Users').doc(docId).get();
//   }

//   static Future<DocumentSnapshot> getUser(String userID) {
//     return FirebaseFirestore.instance.collection('Users').doc(userID).get();
//   }

//   static Future<String> uploadPic(File image, String userID) async {
//     firebase_storage.Reference reference = firebase_storage
//         .FirebaseStorage.instance
//         .ref()
//         .child('Images')
//         .child('Users')
//         .child(userID);
//     firebase_storage.TaskSnapshot storageTaskSnapshot =
//         await reference.putFile(image);
//     final String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

//     return downloadUrl;
//   }

//   static Future<String> uploadFarmPic(File image, String userID) async {
//     firebase_storage.Reference reference = firebase_storage
//         .FirebaseStorage.instance
//         .ref()
//         .child('Images')
//         .child('Farms')
//         .child(userID)
//         .child(image.path);
//     firebase_storage.TaskSnapshot storageTaskSnapshot =
//         await reference.putFile(image);
//     final String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

//     return downloadUrl;
//   }

//   static Future<Map<String, dynamic>> querySingleUser(String userId) async {
//     Map<String, dynamic> data;
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     firebaseFirestore.collection("Users").get().then((querySnapshot) {
//       querySnapshot.docs.forEach((element) {
//         if (element.id == userId) {
//           data = element.data();
//         }
//       });
//     });
//     return data;
//   }
// }

// //the logic that will work is when the app is first launched,
// //user will have the options to choose current location or another location
// //and that location will be saved

// //Next launch make sure that we get the position and the name before we get to the home screen
// //On the home screen, the name is shown on the app bar and when it is clicked it should go to the mapping page

// /// When the location services are not enabled or permissions
// /// are denied the `Future` will return an error.
// Future<Position> _determinePosition() async {
//   bool serviceEnabled;
//   LocationPermission permission;

//   // Test if location services are enabled.
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     // Location services are not enabled don't continue
//     // accessing the position and request users of the
//     // App to enable the location services.
//     return Future.error('Location services are disabled.');
//   }

//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     if (permission == LocationPermission.denied) {
//       // Permissions are denied, next time you could try
//       // requesting permissions again (this is also where
//       // Android's shouldShowRequestPermissionRationale
//       // returned true. According to Android guidelines
//       // your App should show an explanatory UI now.
//       return Future.error('Location permissions are denied');
//     }
//   }

//   // When we reach here, permissions are granted and we can
//   // continue accessing the position of the device.
//   return await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.best);
// }

// //method that fires when the user prefers current location
// Future<bool> preferCurrentLoc() async {
//   try {
//     final _locaData = await _determinePosition();
//     print('____________________________________________________________');
//     print('$_locaData');
//     print('____________________________________________________________');
//     List<Placemark> placemarks =
//         await placemarkFromCoordinates(_locaData.latitude, _locaData.longitude);
//     Placemark place = placemarks[0];
//     Map<String, dynamic> _userAddress = {
//       "location": {"lat": _locaData.latitude, "long": _locaData.longitude},
//       "locationName": place.name,
//       "street": place.street,
//       "country": place.country,
//       "locality": place.locality,
//       "region": place.administrativeArea,
//       "countyCode": place.isoCountryCode
//     };
//     SharedPrefs.savePositionInfo(_userAddress);
//     print('==============================================================');
//     print('${place}');
//     print('==============================================================');
//     return true;
//   } catch (e) {
//     print('location error ' + e.toString());
//     return false;
//   }
// }
