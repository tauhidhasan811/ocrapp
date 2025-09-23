
class ResultComparison {
  List<String> temperatureComparison(
      Map<String, dynamic> imageData,
      Map<String, Map<String, double>> apiData,
      ) {
    List<String> messages = [];

    final List<double> givenTemps = (imageData["temp"] as List<dynamic>? ?? [])
        .map((e) => double.tryParse(e.toString()) ?? 0.0)
        .toList();

    final List<double> givenHumidities = (imageData["humidity"] as List<dynamic>? ?? [])
        .map((e) => double.tryParse(e.toString()) ?? 0.0)
        .toList();

    if (givenTemps.isEmpty || givenHumidities.isEmpty) {
      messages.add("No valid temperature or humidity found in imageData.");
      return messages;
    }

    final double givenHumidity = givenHumidities.first;

    apiData.forEach((city, data) {
      final double apiTemp = data["temp"] ?? 0;
      final double apiHumidity = data["humidity"] ?? 0;

      for (final givenTemp in givenTemps) {

        if (givenTemp == apiTemp) {
          messages.add("Temp $givenTemp°C matches $city ($apiTemp°C).");
        } else if (givenTemp > apiTemp) {
          messages.add("Temp $givenTemp°C is ${(givenTemp - apiTemp).toStringAsFixed(1)}°C higher than $city ($apiTemp°C).");
        } else {
          messages.add("Temp $givenTemp°C is ${(apiTemp - givenTemp).toStringAsFixed(1)}°C lower than $city ($apiTemp°C).");
        }

        if (givenHumidity == apiHumidity) {
          messages.add("Humidity $givenHumidity% matches $city ($apiHumidity%).");
        } else if (givenHumidity > apiHumidity) {
          messages.add("Humidity $givenHumidity% is ${(givenHumidity - apiHumidity).toStringAsFixed(1)}% higher than $city ($apiHumidity%).");
        } else {
          messages.add("Humidity $givenHumidity% is ${(apiHumidity - givenHumidity).toStringAsFixed(1)}% lower than $city ($apiHumidity%).");
        }
      }
    });
    return messages;
  }
}
