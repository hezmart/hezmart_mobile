import 'dart:async';
import 'dart:developer';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hezmart/common/models/app_location_model.dart';
import 'package:hezmart/common/widgets/custom_dialogs.dart';
import 'package:hezmart/core/di/injector.dart';

class LocationService {
  //Requesting for location from user
  static Future<bool> requestPermission() async {
    LocationPermission? permission;
    bool serviceEnabled;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return false;
      } else {
        return true;
        // injector.get<LocationCubit>().updateDateLocationEnabled(true);
      }
    } else {
      if (permission == LocationPermission.deniedForever) {
        return false;
      } else {
        return true;
      }
    }
  }

  // Return Users  Current Location
  static Future<Position?> getPosition() async {
    try {
      return await Geolocator.getCurrentPosition();
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  // Users realtime device location service
  static Stream<ServiceStatus> serviceStatusStream =
      Geolocator.getServiceStatusStream();

  /// User realtime location listener
  static Stream<Position> userLocationStream = Geolocator.getPositionStream();

// var ww = Geocoder2.

  static Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    // serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   CustomDialogs.error(
    //       'Location services are disabled. Please enable the services');
    //   return false;
    // }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      CustomDialogs.error(
          'Location permissions are permanently denied, we cannot request permissions.');
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  static Future<AppLocationModel?> getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    AppLocationModel? location;
    if (hasPermission) {
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) async {
        location = await _getAddressFromLatLng(position);
        return location;

        // setState(() => _currentPosition = position);
      }).catchError((e) {
        logger.i(e);
        return location;
      });
    }

    return location;
  }

  Future<Position?> getLatLong() async {
    final hasPermission = await _handleLocationPermission();
    Position? positon2;
    if (hasPermission) {
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) async {
        positon2 = position;
        return position;
      }).catchError((e) {
        logger.i(e);
        return positon2;
      });
    }

    return positon2;
  }

  static Future<AppLocationModel?> _getAddressFromLatLng(
      Position position) async {
    String address = '';
    AppLocationModel? location;
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      // logger.i('${place.street}, ${place.subLocality}');
      // logger.i('${place.name}, ${place.postalCode}');
      address =
          '${place.street} ${place.subLocality} ${place.locality} ${place.country}';
      location = AppLocationModel(
          lat: position.latitude,
          lng: position.longitude,
          name: place.street.toString(),
          formattedAddress: address,
          state: place.subLocality.toString().isEmpty
              ? place.locality.toString()
              : place.subLocality.toString(),
          city: place.locality.toString());

      return location;
    }).catchError((e) {
      logger.e(e);
      return address;
    });

    return location;
  }
}
