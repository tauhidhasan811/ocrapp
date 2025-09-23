
class TextClassifier {
  final List<String> weatherKeywords = [
    "temperature", "temp", "celsius", "fahrenheit", "°c", "°f",
    "humidity", "hot", "cold", "rain", "snow", "wind"
  ];

  Map<String, dynamic> classify(String text) {
    if (text.trim().isEmpty) {
      return {"category": "Unknown", "matches": {}};
    }

    List<String> words = text
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s°%]'), '')
        .split(RegExp(r'\s+'));

    int length = words.length;
    int matchWeather = words.where((w) => weatherKeywords.contains(w)).length;

    double probability = matchWeather / (length > 0 ? length : 1);
    print("Probability: $probability");

    if (probability < 0.00001) {
      return {"category": "Unknown", "matches": {}};
    }

    RegExp temregex = RegExp(r'(\d{1,2})\s?°');
    List<String> temps = temregex
        .allMatches(text.toLowerCase())
        .map((m) => m.group(1)!)
        .toList();
    print("temp: $temps");

    RegExp humregex = RegExp(r'Humidity:\s*([1-9][0-9]?)%');

    List<String> humidity = humregex
        .allMatches(text)
        .map((m) => m.group(1)!)
        .toList();

    print("humidity: $humidity");
    return {
      "category": "Weather",
      "matches": {"temp": temps, "humidity": humidity}
    };
  }
}
