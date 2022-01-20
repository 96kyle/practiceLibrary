// import 'package:carousel/pages/kakaoMapTest.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';

// class MapLoading extends StatefulWidget {
//   const MapLoading({Key? key}) : super(key: key);

//   @override
//   _MapLoadingState createState() => _MapLoadingState();
// }

// class _MapLoadingState extends State<MapLoading> {
//   @override
//   void initState() {
//     getLocation();
//     super.initState();
//   }

//   getLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//     double lat;
//     double lng;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);

//     lat = position.latitude;
//     lng = position.longitude;

//     print(lat);
//     print(lng);

//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) => KakaoMapTest(
//             lat: lat,
//             lng: lng,
//             ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text("로딩중"),
//       ),
//     );
//   }
// }