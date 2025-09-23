/*import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = "ea77af0c4cc39f24da3be25a6ad83c60"; // 🔑 Replace with your key
  final String baseUrl = "https://api.openweathermap.org/data/2.5/weather";

  /// Get current temp for one city
  Future<double?> _getTemp(String city) async {
    try {

      //final response = await http.get(Uri.parse( "$baseUrl?q=$city&appid=$apiKey&units=metric"));
      final response = await http.get
        (Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=51.5098&lon=-0.1180&appid=7bad9389c36525353b446ebc1da32438"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["main"]["temp"]?.toDouble();
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// Match OCR temperature against a list of cities
  Future<String> findCityByTemperature(String ocrText) async {
    final tempRegex = RegExp(r'(\d+)\s?(°?[CF])', caseSensitive: false);
    final match = tempRegex.firstMatch(ocrText);

    if (match == null) return "No valid temperature found in OCR text.";

    int ocrValue = int.parse(match.group(1)!);
    String unit = match.group(2)!.toUpperCase();

    // Convert to Celsius if Fahrenheit
    if (unit.contains("F")) {
      ocrValue = ((ocrValue - 32) * 5 / 9).round();
    }

    // Candidate cities to check (can extend this list)
    final cities = ["London", "New York", "Paris", "Tokyo", "Delhi", "Sydney"];

    for (var city in cities) {
      final liveTemp = await _getTemp(city);
      if (liveTemp == null) continue;

      if ((ocrValue - liveTemp).abs() <= 1) {
        return "🌍 The temperature $ocrValue°C matches with $city (Live: ${liveTemp.toStringAsFixed(1)}°C).";
      }
    }

    return "❌ No city found with temperature $ocrValue°C in the checked list.";
  }
}


 */


/*
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = "7bad9389c36525353b446ebc1da32438"; // 🔑 Replace with your key
  final String baseUrl = "https://api.openweathermap.org/data/2.5/weather";

  /// Get current temp for given coordinates
  Future<double?> _getTemp(double lat, double lon) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric"),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["main"]["temp"]?.toDouble();
      }
      return null;
    } catch (_) {
      return null;
    }
  }


  final List<String> weatherKeywords = [
    "temperature", "temp", "celsius", "fahrenheit", "°c", "°f",
    "hot", "cold", "warm", "cool", "freezing", "boiling",

    "rain", "rainfall", "drizzle", "shower", "storm", "thunderstorm",
    "lightning", "snow", "snowfall", "blizzard", "hail", "fog",
    "mist", "humidity", "dew", "wet", "precipitation",

    "sunny", "clear", "cloudy", "overcast", "partly cloudy",
    "haze", "smog", "sky", "sunshine", "bright", "dark",

    "wind", "windy", "breeze", "gust", "gale", "hurricane",
    "cyclone", "tornado", "typhoon", "air pressure", "barometer",

    "forecast", "weather", "climate", "season", "atmosphere",
    "heatwave", "drought", "flood", "monsoon",  "celsius", "°c", "c",
    "fahrenheit", "°f", "f",
    "kelvin", "k"
  ];
  final List<String> productKeywords = [
    "phone", "laptop", "ipad", "macbook", "tablet", "computer",
    "charger", "camera", "headphone", "earbuds", "smartwatch",
    "keyboard", "mouse", "monitor", "printer", "speaker",
    "television", "tv", "console", "game", "apparel", "clothes",
    "shoes", "bag", "backpack", "watch", "perfume", "cosmetics",
    "furniture", "sofa", "chair", "table", "bed", "mattress",
    "book", "pen", "notebook", "accessory", "gadget", "device",
    "price", "cost", "amount", "quantity", "qty", "number",
    "total", "piece", "unit", "each", "pack", "set", "bundle",
    "sale", "discount", "offer"
  ];


  Map<String, dynamic> classifyingContext(
      String text, List<String> weatherWords, List<String> productWords) {
    List<String> words = text.toLowerCase().split(RegExp(r'\s+'));
    int length = words.length;

    int matchWeather = words.where((word) => weatherWords.contains(word)).length;
    int matchProduct = words.where((word) => productWords.contains(word)).length;

    double probabilityWeather = matchWeather / length;
    double probabilityProduct = matchProduct / length;

    if (probabilityWeather >= probabilityProduct) {
      RegExp regex = RegExp(r'(\d+)\s?(°C|C|°F|F|%)');
      List<String> matches = regex
          .allMatches(text)
          .map((match) => match.group(0)!)
          .toList();
      return {"category": "Weather", "matches": matches};
    } else {
      RegExp regex = RegExp(r'(\d+)\s?(price|quantity|qty|unit|each|pack|set|bundle)');
      List<String> matches = regex
          .allMatches(text)
          .map((match) => match.group(0)!)
          .toList();
      return {"category": "Product", "matches": matches};
    }
  }

  Future<String> findCityByTemperature(String ocrText) async
  {
    final cityCoords = {
      "London": [51.5098, -0.1180],
      "New York": [40.7128, -74.0060],
      "Paris": [48.8566, 2.3522],
      "Tokyo": [35.6895, 139.6917],
      "Delhi": [28.6139, 77.2090],
      "Sydney": [-33.8688, 151.2093],
    };

    double? lastTemp; // keep track of last temp checked

    for (var entry in cityCoords.entries) {
      final city = entry.key;
      final coords = entry.value;

      final liveTemp = await _getTemp(coords[0], coords[1]);
      if (liveTemp == null) continue;

      lastTemp = liveTemp;

      return "Found city: $city with live temperature ${liveTemp
          .toStringAsFixed(1)}°C.";
    }

    return "No city found. Last checked temp: ${lastTemp?.toStringAsFixed(1) ??
        "N/A"}°C.";
  }
  Future<String> findCityByProduct(String ocrText) async
  {

  }
}

 */

/*
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = "7bad9389c36525353b446ebc1da32438"; // Replace with your key
  final String baseUrl = "https://api.openweathermap.org/data/2.5/weather";

  Future<double?> _getTemp(double lat, double lon) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric"),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["main"]["temp"]?.toDouble();
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  final List<String> weatherKeywords = [
    "temperature", "temp", "celsius", "fahrenheit", "°c", "°f",
    "hot", "cold", "warm", "cool", "freezing", "boiling",
    "rain", "rainfall", "drizzle", "shower", "storm", "thunderstorm",
    "lightning", "snow", "snowfall", "blizzard", "hail", "fog",
    "mist", "humidity", "dew", "wet", "precipitation",
    "sunny", "clear", "cloudy", "overcast", "partly cloudy",
    "haze", "smog", "sky", "sunshine", "bright", "dark",
    "wind", "windy", "breeze", "gust", "gale", "hurricane",
    "cyclone", "tornado", "typhoon", "air pressure", "barometer",
    "forecast", "weather", "climate", "season", "atmosphere",
    "heatwave", "drought", "flood", "monsoon",
    "kelvin", "k"
  ];

  final List<String> productKeywords = [
    "phone", "laptop", "ipad", "macbook", "tablet", "computer",
    "charger", "camera", "headphone", "earbuds", "smartwatch",
    "keyboard", "mouse", "monitor", "printer", "speaker",
    "television", "tv", "console", "game", "apparel", "clothes",
    "shoes", "bag", "backpack", "watch", "perfume", "cosmetics",
    "furniture", "sofa", "chair", "table", "bed", "mattress",
    "book", "pen", "notebook", "accessory", "gadget", "device",
    "price", "cost", "amount", "quantity", "qty", "number",
    "total", "piece", "unit", "each", "pack", "set", "bundle",
    "sale", "discount", "offer"
  ];

  Map<String, dynamic> classifyingContext(
      String text, List<String> weatherWords, List<String> productWords) {
    List<String> words = text.toLowerCase().split(RegExp(r'\s+'));
    int length = words.length;

    int matchWeather = words.where((word) => weatherWords.contains(word)).length;
    int matchProduct = words.where((word) => productWords.contains(word)).length;

    double probabilityWeather = matchWeather / length;
    double probabilityProduct = matchProduct / length;

    if (probabilityWeather >= probabilityProduct) {
      RegExp regex = RegExp(r'(\d+)\s?(°C|C|°F|F|%)');
      List<String> matches =
      regex.allMatches(text).map((m) => m.group(0)!).toList();
      return {"category": "Weather", "matches": matches};
    } else {
      RegExp regex =
      RegExp(r'(\d+)\s?(price|quantity|qty|unit|each|pack|set|bundle)');
      List<String> matches =
      regex.allMatches(text).map((m) => m.group(0)!).toList();
      return {"category": "Product", "matches": matches};
    }
  }

  Future<String> findCityByTemperature(String ocrText) async {
    final cityCoords = {
      "London": [51.5098, -0.1180],
      "New York": [40.7128, -74.0060],
      "Paris": [48.8566, 2.3522],
      "Tokyo": [35.6895, 139.6917],
      "Delhi": [28.6139, 77.2090],
      "Sydney": [-33.8688, 151.2093],
    };

    double? lastTemp;

    for (var entry in cityCoords.entries) {
      final city = entry.key;
      final coords = entry.value;

      final liveTemp = await _getTemp(coords[0], coords[1]);
      if (liveTemp == null) continue;

      lastTemp = liveTemp;

      return "Found city: $city with live temperature ${liveTemp.toStringAsFixed(1)}°C.";
    }

    return "No city found. Last checked temp: ${lastTemp?.toStringAsFixed(1) ?? "N/A"}°C.";
  }

  Future<String> findCityByProduct(String ocrText) async {
    final cityProducts = {
      "London": ["phone", "laptop", "tablet"],
      "New York": ["macbook", "camera", "headphone"],
      "Paris": ["tablet", "smartwatch", "camera"],
      "Tokyo": ["laptop", "console", "game"],
      "Delhi": ["phone", "charger", "mouse"],
      "Sydney": ["printer", "monitor", "keyboard"],
    };

    String lowerText = ocrText.toLowerCase();
    for (var entry in cityProducts.entries) {
      final city = entry.key;
      final products = entry.value;

      bool found = products.any((product) => lowerText.contains(product));
      if (found) {
        RegExp regex =
        RegExp(r'(\d+)\s?(price|quantity|qty|unit|each|pack|set|bundle)');
        List<String> matches =
        regex.allMatches(ocrText).map((m) => m.group(0)!).toList();

        return "Found product in $city. Details: ${matches.isNotEmpty ? matches.join(", ") : "No quantity/price info"}";
      }
    }

    return "No matching product found in any city.";
  }

  Future<void> processOcrText(String ocrText) async {
    var result = classifyingContext(ocrText, weatherKeywords, productKeywords);

    if (result["category"] == "Weather") {
      String cityInfo = await findCityByTemperature(ocrText);
      print(cityInfo);
    } else {
      String productInfo = await findCityByProduct(ocrText);
      print(productInfo);
    }
  }
}

 */


/*
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = "7bad9389c36525353b446ebc1da32438"; // Replace with your key
  final String baseUrl = "https://api.openweathermap.org/data/2.5/weather";

  Future<double?> _getTemp(double lat, double lon) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric"),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return (data["main"]["temp"] as num?)?.toDouble();
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// Returns a map of city -> temperature
  Future<Map<String, double>> findCityByTemperature() async {
    final cityCoords = {
      "London": [51.5098, -0.1180],
      "New York": [40.7128, -74.0060],
      "Paris": [48.8566, 2.3522],
      "Tokyo": [35.6895, 139.6917],
      "Delhi": [28.6139, 77.2090],
      "Sydney": [-33.8688, 151.2093],
    };

    Map<String, double> weatherData = {};

    for (var entry in cityCoords.entries) {
      final city = entry.key;
      final coords = entry.value;

      final liveTemp = await _getTemp(coords[0], coords[1]);
      if (liveTemp != null) {
        weatherData[city] = liveTemp;
      }
    }

    return weatherData;
  }
}


 */

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

  /// Returns a map of city -> {temp, humidity}
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
        print("🤣LiveData: $liveData");
        weatherData[city] = liveData; // {"temp": xx, "humidity": yy}
      }
    }

    print("🤒weatherData: $weatherData");

    return weatherData;
  }
}
