/*
{
"latitude": 52.5,
"longitude": 52.5,
"generationtime_ms": 0.08404254913330078,
"utc_offset_seconds": 0,
"timezone": "GMT",
"timezone_abbreviation": "GMT",
"elevation": 131
}
*/

class WeatherModel {
  double latitude;
  double longitude;
  double generationtime_ms;
  int utc_offset_seconds;
  String timezone;
  String timezone_abbreviation;
  int elevation;

  WeatherModel(
      {required this.latitude,
      required this.longitude,
      required this.generationtime_ms,
      required this.utc_offset_seconds,
      required this.elevation,
      required this.timezone,
      required this.timezone_abbreviation});

  factory WeatherModel.fromMap(Map<String, dynamic> apiDataMap) {
    return WeatherModel(
        latitude: apiDataMap["latitude"],
        longitude: apiDataMap["longitude"],
        generationtime_ms: apiDataMap["generationtime_ms"],
        utc_offset_seconds: apiDataMap["utc_offset_seconds"],
        elevation: apiDataMap["elevation"],
        timezone: apiDataMap["timezone"],
        timezone_abbreviation: apiDataMap["timezone_abbreviation"]);
  }
}
