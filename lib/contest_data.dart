import 'dart:convert';

List<ContestData> contestDataFromJson(String str) => List<ContestData>.from(json.decode(str).map((x) => ContestData.fromJson(x)));

String contestDataToJson(List<ContestData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ContestData {
  ContestData({
    required this.name,
    required this.url,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.in24Hours,
    required this.status,
  });

  String name;
  String url;
  DateTime startTime;
  DateTime endTime;
  String duration;
  String in24Hours;
  String status;

  factory ContestData.fromJson(Map<String, dynamic> json) => ContestData(
        name: json["name"],
        url: json["url"],
        startTime: DateTime.parse(json["start_time"]),
        endTime: DateTime.parse(json["end_time"]),
        duration: json["duration"],
        in24Hours: json["in_24_hours"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
        "start_time": startTime.toIso8601String(),
        "end_time": endTime.toIso8601String(),
        "duration": duration,
        "in_24_hours": in24Hours,
        "status": status,
      };
}
