import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  static LocationService get instance => LocationService.internar();
  const LocationService.internar();

  Future<Position> requistPermission() async {
    late LocationPermission _permission;
    bool isLocationServiceEnabled = false; // * GPS

    isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (isLocationServiceEnabled == false) {
      throw Exception('Please enable location service!');
    }

    _permission = await Geolocator.requestPermission();

    if (_permission == LocationPermission.denied) {
      _permission = await Geolocator.requestPermission();

      if (_permission == LocationPermission.denied ||
          _permission == LocationPermission.deniedForever) {
        await openAppSettings();
        throw Exception('Permission is denied');
      }
    }

    final currentPosition = await getCurrentLocation();

    return currentPosition;
  }

  Future<Position> getCurrentLocation() async {
    try {
      final LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 100,
      );

      final result = await Geolocator.getCurrentPosition(
          locationSettings: locationSettings);

      return result;
    } catch (e) {
      throw Exception('Could not get current location !');
    }
  }

  Future<String> reverseGeocode(double latitude, double longitude) async {
    try {
      final dio = Dio();
      final response = await dio.get(
        'https://nominatim.openstreetmap.org/reverse',
        queryParameters: {
          'format': 'json',
          'lat': latitude,
          'lon': longitude,
          'zoom': 10,
          'addressdetails': 1,
        },
        options: Options(
          headers: {
            'User-Agent': 'DeliveryApp/1.0',
          },
          receiveTimeout: const Duration(seconds: 3),
          sendTimeout: const Duration(seconds: 3),
        ),
      );
      if (response.statusCode == 200 && response.data != null) {
        final address = response.data['address'];
        if (address != null) {
          final city = address['city'] ?? address['town'] ?? address['village'] ?? address['suburb'] ?? address['county'] ?? address['state'];
          if (city != null) {
            return city.toString();
          }
          final display = response.data['display_name'];
          if (display != null) {
            return display.toString();
          }
        }
      }
    } catch (e) {
      // Fallback below
    }

    // Local coordinate approximation for Uzbekistan cities if API fails or offline
    if (latitude >= 41.0 && latitude <= 41.5 && longitude >= 69.0 && longitude <= 69.5) {
      return "Tashkent";
    } else if (latitude >= 39.4 && latitude <= 39.8 && longitude >= 66.7 && longitude <= 67.1) {
      return "Samarkand";
    } else if (latitude >= 40.5 && latitude <= 41.0 && longitude >= 72.1 && longitude <= 72.6) {
      return "Andijon";
    } else if (latitude >= 39.9 && latitude <= 40.3 && longitude >= 67.6 && longitude <= 68.1) {
      return "Jizzax";
    } else if (latitude >= 39.9 && latitude <= 40.3 && longitude >= 65.1 && longitude <= 65.6) {
      return "Navoiy";
    }

    return "Tashkent"; // Default fallback
  }
}