/*
import 'package:google_ml_kit/google_ml_kit.dart';

Class ResultComp{
  List<String> tempetectureComp(tempValue, weatherData)
  {
    weatherData = weatherData.entries
        .map((e) => "${e.key}: ${e.value}°C")
        .join(", ");
    final city = weatherData["category"];
    final temp = weatherData["matches"];
    List<String> Message=[];
    for i in range(tempValue.length)
    {
      for j in range(city)
      {
        if(tempValue[i] == temp[j])
          {
            Message.add("Both Given Temperacture and $city[j] temparacture are same $tempValue[i]")
          }
        else if(tempValue[i] > temp[j])
        {
          float dif = tempValue[i] - temp[j]
          Message.add("Given Temperacture and $city[j] temparacture are $dif Higher")
        }
        else if(tempValue[i] < temp[j])
        {
          float dif = temp[j] - tempValue[i]
          Message.add("Given Temperacture and $city[j] temparacture are $dif Lower")
        }
      }
    }
  }
}

 */

/*
class ResultComparison {
  List<String> temperatureComparison(List<double> tempValues, Map<String, double> weatherData) {
    List<String> messages = [];

    for (var givenTemp in tempValues) {
      weatherData.forEach((city, cityTemp) {
        if (givenTemp == cityTemp) {
          messages.add("Both given temperature and $city temperature are same ($givenTemp°C)");
        } else if (givenTemp > cityTemp) {
          double diff = givenTemp - cityTemp;
          messages.add("Given temperature is $diff°C higher than $city temperature");
        } else {
          double diff = cityTemp - givenTemp;
          messages.add("Given temperature is $diff°C lower than $city temperature");
        }
      });
    }

    return messages;
  }
}

 */

/*
class ResultComparison {
  final List<String> tempMessages = [];
  final List<String> humidityMessages = [];

  /// Compare extracted image data with live API data
  List<String> temperatureComparison(
      Map<String, dynamic> imageData,
      Map<String, Map<String, double>> apiData,
      ) {
    List<String> messages = [];

    double? givenTemp = imageData["matches"]?["temp"];
    double? givenHumidity = imageData["matches"]?["humidity"];

    if (givenTemp == null || givenHumidity == null) {
      messages.add("No valid temperature or humidity found in imageData.");
      return messages;
    }

    // Loop over cities from API data
    apiData.forEach((city, data) {
      double apiTemp = data["temp"] ?? 0;
      double apiHumidity = data["humidity"] ?? 0;

      // ---- Temperature comparison ----
      if (givenTemp == apiTemp) {
        tempMessages.add(
            "Both given temperature and $city temperature are the same ($givenTemp°C).");
      } else if (givenTemp > apiTemp) {
        double diff = (givenTemp - apiTemp);
        tempMessages.add(
            "Given temperature ($givenTemp°C) is $diff°C higher than $city ($apiTemp°C).");
      } else {
        double diff = (apiTemp - givenTemp);
        tempMessages.add(
            "Given temperature ($givenTemp°C) is $diff°C lower than $city ($apiTemp°C).");
      }

      // ---- Humidity comparison ----
      if (givenHumidity == apiHumidity) {
        humidityMessages.add(
            "Both given humidity and $city humidity are the same ($givenHumidity%).");
      } else if (givenHumidity > apiHumidity) {
        double diff = (givenHumidity - apiHumidity);
        humidityMessages.add(
            "Given humidity ($givenHumidity%) is $diff% higher than $city ($apiHumidity%).");
      } else {
        double diff = (apiHumidity - givenHumidity);
        humidityMessages.add(
            "Given humidity ($givenHumidity%) is $diff% lower than $city ($apiHumidity%).");
      }
    });

    // Merge results
    messages.addAll(tempMessages);
    messages.addAll(humidityMessages);
    return messages;
  }
}


 */

class ResultComparison {
  /// Compare extracted image data with live API data
  List<String> temperatureComparison(
      Map<String, dynamic> imageData,
      Map<String, Map<String, double>> apiData,
      ) {
    List<String> messages = [];

    // Extract lists from imageData
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

    // Use first humidity for comparison (usually only one)
    final double givenHumidity = givenHumidities.first;

    // Loop through cities
    apiData.forEach((city, data) {
      final double apiTemp = data["temp"] ?? 0;
      final double apiHumidity = data["humidity"] ?? 0;

      // Compare each extracted temp
      for (final givenTemp in givenTemps) {
        // Temperature comparison
        if (givenTemp == apiTemp) {
          messages.add("Temp $givenTemp°C matches $city ($apiTemp°C).");
        } else if (givenTemp > apiTemp) {
          messages.add("Temp $givenTemp°C is ${(givenTemp - apiTemp).toStringAsFixed(1)}°C higher than $city ($apiTemp°C).");
        } else {
          messages.add("Temp $givenTemp°C is ${(apiTemp - givenTemp).toStringAsFixed(1)}°C lower than $city ($apiTemp°C).");
        }

        // Humidity comparison
        if (givenHumidity == apiHumidity) {
          messages.add("Humidity $givenHumidity% matches $city ($apiHumidity%).");
        } else if (givenHumidity > apiHumidity) {
          messages.add("Humidity $givenHumidity% is ${(givenHumidity - apiHumidity).toStringAsFixed(1)}% higher than $city ($apiHumidity%).");
        } else {
          messages.add("Humidity $givenHumidity% is ${(apiHumidity - givenHumidity).toStringAsFixed(1)}% lower than $city ($apiHumidity%).");
        }
      }
    });
    print("😒😍😍😍 hof: $messages");
    return messages;
  }
}
