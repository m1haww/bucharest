// api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bucharest/models/forecast.dart';

Future<List<ForecastDay>> fetchForecast(String location) async {
  try {
    final url =
        "http://api.weatherapi.com/v1/forecast.json?key=91cf32e8d20c4733978164917242412&q=$location&days=7";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final forecastList = data['forecast']['forecastday'] as List;

      return forecastList.map((day) => ForecastDay.fromJson(day)).toList();
    } else {
      throw Exception('Failed to load forecast data: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error fetching forecast data: $e');
  }
}
