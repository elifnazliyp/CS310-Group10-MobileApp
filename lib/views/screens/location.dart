import 'dart:async';

/*import 'package:firebase_crud_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

*/
/*
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Location',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Get Your Location '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Location location = Location();
  LocationData? _locData;
  PermissionStatus? _permissionStatus;
  StreamSubscription<LocationData>? _locSubscription;
  bool? _serviceEnabled;
  bool _loading = false;
  String? _error;

  Future<void> _checkPermissions() async {
    final PermissionStatus status = await location.hasPermission();
    setState(() {
      _permissionStatus = status;
    });
  }

  Future<void> _requestPermissions() async {
    if(_permissionStatus != PermissionStatus.granted) {
      final PermissionStatus status = await location.requestPermission();
      setState(() {
        _permissionStatus = status;
      });
    }
  }

  Future<void> _checkService() async {
    final bool service = await location.serviceEnabled();
    setState(() {
      _serviceEnabled = service;
    });
  }

  Future<void> _requestService() async {
    if(_serviceEnabled == true) {
      return;
    }
    final bool serviceRequest = await location.requestService();
    setState(() {
      _serviceEnabled = serviceRequest;
    });
  }

  Future<void> _getLocation() async {
    setState(() {
      _error = null;
      _loading = true;
    });
    try {
      final LocationData _locResult = await location.getLocation();
      setState(() {
        _locData = _locResult;
        _loading = false;
      });
    } on PlatformException catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Future<void> _listenLocation() async {
    _locSubscription = location.onLocationChanged.handleError((dynamic e) {
      if(e is PlatformException) {
        setState(() {
          _error = e.toString();
        });
      }
      _locSubscription?.cancel();
      setState(() {
        _locSubscription = null;
      });
    }).listen((LocationData current) {
      setState(() {
        _error = null;
        _locData = current;
      });
    });

    setState(() {});
  }

  Future<void> _stopListen() async {
    _locSubscription?.cancel();
    setState(() {
      _locSubscription = null;
    });
  }

  @override
  void dispose() {
    _locSubscription?.cancel();
    setState(() {
      _locSubscription = null;
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: <Widget>[
              Text('Permission status: ${_permissionStatus ?? 'Unknown'}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      onPressed: _checkPermissions,
                      child: const Text('Check'),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton(
                    onPressed: _requestPermissions,
                    child: const Text('Request'),
                  ),
                ]
              ),

              const Divider(),

              Text('Service status: ${_serviceEnabled ?? 'Look'}'),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: _checkService,
                      child: const Text('Check'),
                    ),
                    const SizedBox(width: 16),
                    OutlinedButton(
                      onPressed: _requestService,
                      child: const Text('Request'),
                    ),
                  ]
              ),

              const Divider(),

              Text('Location: '+(_error ?? '${_locData ?? 'Check'}')),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: _getLocation,
                      child: _loading ?
                          const CircularProgressIndicator(
                            color: Colors.blue,
                          )
                          :
                      const Text('Get Location'),
                    ),
                  ]
              ),

              const Divider(),

              Text('Listen location: '+(_error ?? '${_locData ?? 'Look'}')),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: _listenLocation,
                      child: const Text('Listen'),
                    ),
                    const SizedBox(width: 16),
                    OutlinedButton(
                      onPressed: _stopListen,
                      child: const Text('Stop'),
                    ),
                  ]
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:geocoding/geocoding.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String location = 'Null, Press Button';
  String Address = 'search';
  String showAdress = 'sear';

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.

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
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    showAdress =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    Address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {});
  }

  Future<String> GetAddressFromLatLongremastered(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    return Address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Coordinates Points',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              location,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'ADDRESS',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text('${Address}'),
            ElevatedButton(
                onPressed: () async {
                  Position position = await _getGeoLocationPosition();

                  location =
                      'Lat: ${position.latitude} , Long: ${position.longitude}';
                  GetAddressFromLatLong(position);

                  print('first one is ' + Address);
                },
                child: Text('Get Location')),
            Text('${Address}'),
          ],
        ),
      ),
    );
  }
}
