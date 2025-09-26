import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../app.dart';

class HomeController extends GetxController {
  final state = HomeState();

  Future<void> get() async {
    state.isLoading(true);
    state.isHasError(false);

    final result = await UserApi.getUser();

    state.isLoading(false);

    if (result == null) {
      state.isHasError(true);
      return;
    } else {
      state.userModel.value = result;
    }
  }

  @override
  void onInit() {
    getCurrentLocation();
    get();
    super.onInit();
  }

  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
