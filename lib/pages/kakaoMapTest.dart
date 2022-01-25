import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';

class KakaoMapTest extends StatefulWidget {
  const KakaoMapTest({
    Key? key,
  }) : super(key: key);

  @override
  _KakaoMapTestState createState() => _KakaoMapTestState();
}

class _KakaoMapTestState extends State<KakaoMapTest> {
  Position? position;

  @override
  void initState() {
    super.initState();

    getLocation();
  }

  Future getLocation() async {
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

    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KAKAO MAP'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: position == null
                  ? CircularProgressIndicator()
                  : LayoutBuilder(
                      builder: (context, constraints) => KakaoMapView(
                        mapController: (controller) {
                          controller.reload();
                        },
                        width: constraints.maxWidth,
                        height: constraints.maxHeight,
                        kakaoMapKey: 'b2be67d07577e01b5562ae029e819c6a',
                        lat: position!.latitude,
                        lng: position!.longitude,
                        zoomLevel: 5,
                        showMapTypeControl: true,
                        showZoomControl: true,
                        overlayText: '왜 여기지?',
                        markerImageURL:
                            'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png',
                        onTapMarker: (message) {},
                      ),
                    ),
            ),
          ),
          TextButton(
            onPressed: () async {
              position = null;

              setState(() {});
              await getLocation();
            },
            child: Text("refresh"),
          ),
        ],
      ),
    );
  }
}
