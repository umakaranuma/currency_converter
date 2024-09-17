import '../constants/api.dart';

enum Moad { live, test, dubug }

const currentMoad =
    Moad.dubug; // Change this based on your logic for determining the mode

class AppConfig {
  static String get apiUrl {
    if (currentMoad == Moad.dubug) {
      return DebugApi.apiUrl;
    } else if (currentMoad == Moad.live) {
      return LiveApi.apiUrl;
    } else if (currentMoad == Moad.test) {
      return TestApi.apiUrl;
    } else {
      // Default to debug mode if mode is unknown
      return DebugApi.apiUrl;
    }
  }
}
