import 'dart:convert';
import 'package:http/http.dart' as http;
class WeatherService {
  final String apiKey = "7bad9389c36525353b446ebc1da32438"; // Replace with your key
  final String baseUrl = "https://api.openweathermap.org/data/2.5/weather";

  /// Get temperature & humidity for one location
  Future<Map<String, double>?> _getTemp(double lat, double lon) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric"),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final double? temp = (data["main"]["temp"] as num?)?.toDouble();
        final double? humidity = (data["main"]["humidity"] as num?)?.toDouble();

        if (temp != null && humidity != null) {
          return {
            "temp": temp,
            "humidity": humidity,
          };
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, Map<String, double>>> findCityByTemperature() async {
    final cityCoords = {
      "London": [51.5098, -0.1180],
      "New York": [40.7128, -74.0060],
      "Paris": [48.8566, 2.3522],
      "Tokyo": [35.6895, 139.6917],
      "Delhi": [28.6139, 77.2090],
      "Sydney": [-33.8688, 151.2093],
    };

    Map<String, Map<String, double>> weatherData = {};

    for (var entry in cityCoords.entries) {
      final city = entry.key;
      final coords = entry.value;

      final liveData = await _getTemp(coords[0], coords[1]);
      if (liveData != null) {
        print("LiveData: $liveData");
        weatherData[city] = liveData;
      }
    }


    return weatherData;
  }
}
