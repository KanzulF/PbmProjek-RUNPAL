class User {
  final String id;
  String? name;
  String? email;
  String? password;
  // String? gender;
  // int? age;
  int? level;
  int? distance;
  int? goals;

  User({
    required this.id,
    this.name,
    this.email,
    this.password,
    // this.gender,
    // this.age,
    this.level,
    this.distance,
    this.goals,
  });

  static User fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        password: json['password'],
        // gender: json['gender'],
        // age: json['age'],
        level: json['level'],
        distance: json['distance'],
        goals: json['goals'],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      // 'gender': gender,
      // 'age': age,
      'level': level,
      'distance': distance,
      'goals': goals,
    };
  }
}
