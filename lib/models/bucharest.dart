class bucharest {
  final String location;
  final String condition;
  final String iconUrl;
  final double temperature;
  final double feelsLike;
  final double windSpeed;
  final double humidity;
  final double pressure;
  final String lastUpdated;

  bucharest({
    required this.location,
    required this.condition,
    required this.iconUrl,
    required this.temperature,
    required this.feelsLike,
    required this.windSpeed,
    required this.humidity,
    required this.pressure,
    required this.lastUpdated,
  });

  factory bucharest.fromJson(Map<String, dynamic> json) {
    return bucharest(
      location: json['location']['name'],
      condition: json['current']['condition']['text'],
      iconUrl: 'https:' + json['current']['condition']['icon'],
      temperature: json['current']['temp_c'],
      feelsLike: json['current']['feelslike_c'],
      windSpeed: json['current']['wind_kph'],
      humidity: json['current']['humidity'],
      pressure: json['current']['pressure_mb'],
      lastUpdated: json['current']['last_updated'],
    );
  }
}
