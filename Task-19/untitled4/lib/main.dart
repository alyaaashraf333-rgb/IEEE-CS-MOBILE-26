import 'package:flutter/material.dart';
import 'services/weather_service.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const WeatherHomePage(),
    );
  }
}

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  final TextEditingController _cityController = TextEditingController();

  Map<String, dynamic>? _weatherData;
  bool _isLoading = false;
  String _errorMessage = "";

  @override
  void initState() {
    super.initState();
    _cityController.text = 'Cairo';
    _fetchWeather('Cairo');
  }

  // دالة جلب البيانات بتستدعي الـ Service دلوقتي
  Future<void> _fetchWeather(String city) async {
    if (city.isEmpty) return;

    setState(() {
      _isLoading = true;
      _errorMessage = "";
      _weatherData = null;
    });

    // استدعاء الـ API من الملف الخارجي
    final data = await WeatherService.fetchWeather(city);

    setState(() {
      if (data != null) {
        _weatherData = data;
      } else {
        _errorMessage = "المدينة غير موجودة أو حصل خطأ. حاول تاني.";
      }
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E3C72), Color(0xFF2A5298), Color(0xFF003973)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _cityController,
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                        decoration: InputDecoration(
                          hintText: 'ابحث عن مدينة...',
                          hintStyle: const TextStyle(color: Colors.white54),
                          prefixIcon: const Icon(Icons.search, color: Colors.white70),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        onSubmitted: (value) => _fetchWeather(value),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () => _fetchWeather(_cityController.text),
                        icon: const Icon(Icons.arrow_forward, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(child: _buildContent()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator(color: Colors.white));
    }

    if (_errorMessage.isNotEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            _errorMessage,
            style: const TextStyle(color: Colors.white, fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (_weatherData == null) {
      return const Center(
        child: Text('ادخل اسم مدينة للبدء', style: TextStyle(color: Colors.white70)),
      );
    }

    final location = _weatherData!['location'];
    final current = _weatherData!['current'];
    final forecastDays = _weatherData!['forecast']['forecastday'];

    final cityName = location['name'];
    final country = location['country'];
    final temp = current['temp_c'].round();
    final condition = current['condition']['text'];
    String iconUrl = current['condition']['icon'];

    if (iconUrl.startsWith('//')) iconUrl = 'https:$iconUrl';
    iconUrl = iconUrl.replaceAll('64x64', '128x128');

    final humidity = current['humidity'];
    final windKph = current['wind_kph'];

    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            '$cityName, $country',
            style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Image.network(iconUrl, width: 120, height: 120),
          const SizedBox(height: 5),
          Text(
            '$temp°',
            style: const TextStyle(color: Colors.white, fontSize: 80, fontWeight: FontWeight.w200),
          ),
          Text(
            condition,
            style: const TextStyle(color: Colors.white70, fontSize: 20),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDetailItem(Icons.water_drop, 'الرطوبة', '$humidity%'),
                Container(width: 1, height: 30, color: Colors.white24),
                _buildDetailItem(Icons.air, 'الرياح', '$windKph كم/س'),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                'توقعات 3 أيام',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: forecastDays.map<Widget>((day) {
                final date = DateTime.parse(day['date']);
                final dayName = _getDayName(date);
                final maxTemp = day['day']['maxtemp_c'].round();
                final minTemp = day['day']['mintemp_c'].round();
                String dayIcon = day['day']['condition']['icon'];
                if (dayIcon.startsWith('//')) dayIcon = 'https:$dayIcon';

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 80,
                        child: Text(
                          dayName,
                          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Image.network(dayIcon, width: 40, height: 40),
                      Row(
                        children: [
                          Text('$maxTemp°', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(width: 15),
                          Text('$minTemp°', style: const TextStyle(color: Colors.white54, fontSize: 18)),
                        ],
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70, size: 24),
        const SizedBox(height: 5),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 12)),
      ],
    );
  }

  String _getDayName(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final checkDate = DateTime(date.year, date.month, date.day);

    if (checkDate == today) return 'اليوم';
    if (checkDate == tomorrow) return 'غداً';

    final weekdays = ['الإثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت', 'الأحد'];
    return weekdays[date.weekday - 1];
  }
}