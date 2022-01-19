import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';

class KakaoMapTest extends StatefulWidget {
  // final double lat;
  // final double lng;

  const KakaoMapTest({
    Key? key,
    // required this.lat,
    // required this.lng,
  }) : super(key: key);

  @override
  _KakaoMapTestState createState() => _KakaoMapTestState();
}

class _KakaoMapTestState extends State<KakaoMapTest> {
  final double lat = 33.450701;
  final double lng = 126.570667;

  @override
  void initState() {
    super.initState();
  }

  Future<Position> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KAKAO MAP'),
      ),
      body: Container(
        child: Container(
          alignment: Alignment.center,
          child: FutureBuilder(
              future: getLocation(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData == false) {
                  return Text('잠시만요');
                } else {
                  return KakaoMapView(
                      width: 400,
                      height: 400,
                      kakaoMapKey: 'b2be67d07577e01b5562ae029e819c6a',
                      lat: snapshot.data.latitude,
                      lng: snapshot.data.longitude,
                      zoomLevel: 5,
                      showMapTypeControl: true,
                      showZoomControl: true,
                      overlayText: '왜 여기지?',
                      markerImageURL:
                          'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png',
                      onTapMarker: (message) {});
                }
              }),
        ),
      ),
    );
  }
}
