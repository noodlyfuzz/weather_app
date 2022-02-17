import 'package:flutter/material.dart';
import 'package:weather_app/MainScreen/geolocation.dart';
import 'package:weather_app/ForecastWindow/forecast_widget.dart';
import 'package:weather_app/TodaysWindow/today_weather_widget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  _MainScreenWidgetState createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 0;
  String _title = 'Awesome Weather';
  String? forecastLocation = '';

  @override
  initState() {
    _title = 'Today';
    getLocation();
  }

  void onSelectedTab(int index) {
    if (_selectedTab == index) return;

    switch (index) {
      case 0:
        {
          _title = 'Today';
        }
        break;
      case 1:
        {
          _title = forecastLocation!;
        }
        break;
    }

    setState(() {
      _selectedTab = index;
    });
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
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

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void getLocation() async {
    Position position = await _getGeoLocationPosition();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    forecastLocation = '${place.locality}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedTab,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color.fromARGB(255, 255, 255, 255),
          unselectedItemColor: Color.fromARGB(184, 2, 162, 173),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.today), label: 'today'),
            BottomNavigationBarItem(
                icon: Icon(Icons.cloud_circle_sharp), label: 'forecast'),
          ],
          onTap: onSelectedTab,
        ),
        appBar: AppBar(
          title: Text(_title),
          centerTitle: true,
        ),
        body: IndexedStack(
          index: _selectedTab,
          children: [
            TodayWeatherWidget(),
            ForecastWidget(),
          ],
        ));
  }
}
