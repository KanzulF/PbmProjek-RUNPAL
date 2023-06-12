class Activity {
  final String id;
  final String name;
  final String description;
  final DateTime date;

  Activity(
      {required this.id,
      required this.name,
      required this.description,
      required this.date});

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      date: DateTime.parse(json['date']),
    );
  }
}
