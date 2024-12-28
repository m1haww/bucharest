import 'package:flutter/material.dart';

class alfa extends StatelessWidget {
  const alfa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.location_on, color: Color(0xffa3865d), size: 28),
                SizedBox(width: 8),
                Text(
                  "Bucharest, RO",
                  style: TextStyle(
                    color: Color(0xff8a6d3b),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: const Color(0x000ff555),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0x000ff777), Color(0x000ff555)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0x000ff555), Color(0x000ff777), Color(0x000ff000)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const Text(
              "Hourly Forecast",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff8a6d3b),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5, // Example count
                itemBuilder: (context, index) {
                  return HourlyForecastItem(
                    time: "${5 + index}:00 AM",
                    temp: "${23 - index}°",
                    icon: Icons.wb_sunny, // Placeholder
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Next 14 Days",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff8a6d3b),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SevenDayForecastPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "See All",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff8a6d3b),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const DailyForecastCard(
              day: "Tomorrow",
              condition: "Light Rain Showers",
              maxTemp: 18,
              minTemp: 10,
              chance: 68,
              precipitation: 0.9,
              wind: 18,
              uvi: 2,
            ),
            const DailyForecastCard(
              day: "Tuesday, 18 Oct",
              condition: "Sunny",
              maxTemp: 17,
              minTemp: 7,
              chance: 10,
              precipitation: 0.0,
              wind: 10,
              uvi: 5,
            ),
          ],
        ),
      ),
    );
  }
}

class SevenDayForecastPage extends StatelessWidget {
  const SevenDayForecastPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> forecastData = [
      {"day": "Monday", "condition": "Sunny", "maxTemp": 19, "minTemp": 9},
      {"day": "Tuesday", "condition": "Cloudy", "maxTemp": 18, "minTemp": 10},
      {"day": "Wednesday", "condition": "Rainy", "maxTemp": 15, "minTemp": 8},
      {"day": "Thursday", "condition": "Windy", "maxTemp": 16, "minTemp": 7},
      {
        "day": "Friday",
        "condition": "Partly Cloudy",
        "maxTemp": 17,
        "minTemp": 9
      },
      {"day": "Saturday", "condition": "Sunny", "maxTemp": 20, "minTemp": 11},
      {"day": "Sunday", "condition": "Rainy", "maxTemp": 14, "minTemp": 6},
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xffa3865d),
          ),
        ),
        title: const Text(
          "Weekcast",
          style:
              TextStyle(color: Color(0xff8a6d3b), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: forecastData.length,
        itemBuilder: (context, index) {
          final dayData = forecastData[index];
          return DailyForecastCard(
            day: dayData["day"],
            condition: dayData["condition"],
            maxTemp: dayData["maxTemp"],
            minTemp: dayData["minTemp"],
            chance: 50,
            precipitation: 1.2,
            wind: 15,
            uvi: 3,
          );
        },
      ),
    );
  }
}

class HourlyForecastItem extends StatelessWidget {
  final String time;
  final String temp;
  final IconData icon;

  const HourlyForecastItem({
    super.key,
    required this.time,
    required this.temp,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      width: 80,
      decoration: BoxDecoration(
        color: const Color(0x0ff09020),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0xff524331),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: const Color(0xffa3865d)),
          const SizedBox(height: 5),
          Text(temp,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xffa3865d))),
          const SizedBox(height: 5),
          Text(time,
              style: const TextStyle(color: Color(0xffc9c9c9), fontSize: 12)),
        ],
      ),
    );
  }
}

class DailyForecastCard extends StatelessWidget {
  final String day;
  final String condition;
  final int maxTemp;
  final int minTemp;
  final int chance;
  final double precipitation;
  final int wind;
  final int uvi;

  const DailyForecastCard({
    super.key,
    required this.day,
    required this.condition,
    required this.maxTemp,
    required this.minTemp,
    required this.chance,
    required this.precipitation,
    required this.wind,
    required this.uvi,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0x0ff09020),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0xff524331),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            day,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0xff8a6d3b),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            condition,
            style: const TextStyle(color: Color(0xffc9c9c9)),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ForecastDetail(
                  icon: Icons.umbrella, label: "$chance%", title: "Chance"),
              ForecastDetail(
                  icon: Icons.opacity,
                  label: "$precipitation mm",
                  title: "Precip."),
              ForecastDetail(
                  icon: Icons.wind_power, label: "$wind km/h", title: "Wind"),
              ForecastDetail(icon: Icons.wb_sunny, label: "$uvi", title: "UVI"),
            ],
          ),
        ],
      ),
    );
  }
}

class ForecastDetail extends StatelessWidget {
  final IconData icon;
  final String label;
  final String title;

  const ForecastDetail({
    super.key,
    required this.icon,
    required this.label,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xffa3865d)),
        const SizedBox(height: 5),
        Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xffc9c9c9))),
        const SizedBox(height: 2),
        Text(title,
            style: const TextStyle(color: Color(0xffc9c9c9), fontSize: 12)),
      ],
    );
  }
}
