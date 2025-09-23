/*class TextClassifier {
  /// Classify the given text into a category
  String classify(String text) {
    text = text.trim();

    // Temperature detection (e.g., 28C, 72 F, 100°C)
    final tempRegex = RegExp(r'(\d+)\s?(°?[CF])', caseSensitive: false);
    if (tempRegex.hasMatch(text)) {
      return "Temperature";
    }

    // Price detection (e.g., $12, 99.99 USD, ₹500, €30)
    final priceRegex = RegExp(r'(\$|₹|€|£)?\s?\d+(\.\d{1,2})?\s?(USD|INR|EUR|GBP)?',
        caseSensitive: false);
    if (priceRegex.hasMatch(text)) {
      return "Price";
    }

    // Product detection (simplified: contains words like "item", "product", "model")
    final productKeywords = ["item", "product", "model", "brand", "code"];
    if (productKeywords.any((word) => text.toLowerCase().contains(word))) {
      return "Product";
    }

    // If nothing matches
    return "None";
  }
}

 */

/*
class TextClassifier
{
  /// Classify the given text into a category
  String classify(String text) {
    text = text.trim();

    // Temperature detection (matches 28C, 72 F, 100°C, 36.6 °C, etc.)
    final tempRegex = RegExp(r'\b\d{1,3}(\.\d+)?\s?(°?[CF])\b', caseSensitive: false);
    if (tempRegex.hasMatch(text)) {
      return "Temperature";
    }

    // Price detection (matches $12, 99.99 USD, ₹500, €30, £45.50)
    final priceRegex = RegExp(
        r'(\$|₹|€|£)?\s?\d+(\.\d{1,2})?\s?(USD|INR|EUR|GBP)?',
        caseSensitive: false);
    if (priceRegex.hasMatch(text)) {
      return "Price";
    }

    // Product detection (contains keywords like "item", "product", "model", "brand", "code")
    final productKeywords = ["item", "product", "model", "brand", "code"];
    if (productKeywords.any((word) => text.toLowerCase().contains(word))) {
      return "Product";
    }

    // If nothing matches
    return "None";
  }
}
*/


/*
class TextClassifier()
{
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

 */


/*
class TextClassifier {
  final List<String> weatherKeywords = [
    "temperature", "temp", "celsius", "fahrenheit", "°c", "°f",
    "hot", "cold", "warm", "cool", "freezing", "boiling", "chilly", "frost", "frosty", "scorching", "icy",
    "rain", "rainfall", "drizzle", "shower", "storm", "rainstorm", "downpour", "thunderstorm",
    "thunder", "lightning", "lightning bolt",
    "snow", "snowfall", "blizzard", "sleet", "hail", "ice",
    "fog", "mist", "haze", "smog", "dew", "frost",
    "dust", "duststorm", "sandstorm", "visibility",
    "sunny", "clear", "cloudy", "overcast", "partly", "partly cloudy", "sky", "sunshine", "bright", "dark", "moon",
    "wind", "windy", "breeze", "gust", "gale", "stormy winds", "draft", "airflow",
    "hurricane", "cyclone", "tornado", "typhoon", "tempest", "gale-force",
    "air", "pressure", "barometer", "atmosphere",
    "forecast", "weather", "climate", "season",
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

  Map<String, dynamic> classify(String text) {
    if (text.trim().isEmpty) {
      return {"category": "Unknown", "matches": []};
    }

    List<String> words = text
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s°%]'), '') // remove punctuation
        .split(RegExp(r'\s+'));

    int length = words.length;
    int matchWeather = words.where((w) => weatherKeywords.contains(w)).length;
    int matchProduct = words.where((w) => productKeywords.contains(w)).length;

    if (matchWeather == 0 && matchProduct == 0) {
      return {"category": "Unknown", "matches": []};
    }

    if (matchWeather >= matchProduct) {
      RegExp regex = RegExp(r'(\d+(\.\d+)?)\s?(°c|c|°f|f|percent|%)');
      List<String> matches =
      regex.allMatches(text.toLowerCase()).map((m) => m.group(0)!).toList();
      return {"category": "Weather", "matches": matches};
    } else {
      RegExp regex = RegExp(r'(\d+)\s?(price|quantity|qty|unit|each|pack|set|bundle|items|pieces)');
      List<String> matches =
      regex.allMatches(text.toLowerCase()).map((m) => m.group(0)!).toList();
      return {"category": "Product", "matches": matches};
    }
  }
}


 */
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

    /*
    RegExp temregex = RegExp(r'\b([1-9])\b\s?(°c|°f|c|f)?');
    List<String> temps = temregex
        .allMatches(text.toLowerCase())
        .map((m) => m.group(1)!) // only the number 1-9
        .toList();
    print("temp: $temps");

// Extract **only numbers 1 to 9** for humidity
    RegExp humregex = RegExp(r'\b([1-9])\b\s?(%|percent)?');
    List<String> humidity = humregex
        .allMatches(text.toLowerCase())
        .map((m) => m.group(1)!)
        .toList();

     */
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
