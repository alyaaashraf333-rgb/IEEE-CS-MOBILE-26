import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {

  static const String apiKey = "f92417adebf74911ae6223847231204";
  static const String baseUrl = "https://api.weatherapi.com/v1";

  static Future<Map<String, dynamic>?> fetchWeather(String city) async {
    try {
      final url = Uri.parse(
          '$baseUrl/forecast.json?key=$apiKey&q=$city&days=3&aqi=no&alerts=no');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('فشل تحميل البيانات (Status: ${response.statusCode})');
      }
    } catch (e) {
      print('خطأ في الـ API: $e');
      return null;
    }
  }
}