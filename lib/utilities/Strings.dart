import 'package:sprintf/sprintf.dart';

class Strings {
  static const API_KEY = 'get your api from https://www.pexels.com/';
  static const PEXEL_API_KEY = 'get your api from https://openweathermap.org';
  static const GEO_LOCATOR = 'https://api.openweathermap.org/data/2.5/weather?lat=%s&lon=%s&appid=%s&units=imperial';
  static const CITY_LOCATOR = 'https://api.openweathermap.org/data/2.5/weather?q=%s&appid=%s&units=imperial';
  static const PHOTO_QUERY = "https://api.pexels.com/v1/search?query=%s&per_page=1";
  static const TIME_IN_LOCAtION = '%s in %s!';

  static String getWeatherLocationUrl(double lat, double lon) {
    return sprintf(GEO_LOCATOR, [lat.toString(), lon.toString(), API_KEY]);
  }

  static String getWeatherCityUrl(city) {
    return sprintf(CITY_LOCATOR, [city, API_KEY]);
  }

  static String getPhotoByCity(city) {
    return sprintf(PHOTO_QUERY, [city]);
  }

  static Map<String, String> getPhotoHeader() {
    return {
      "Authorization": PEXEL_API_KEY
    };
  }
}