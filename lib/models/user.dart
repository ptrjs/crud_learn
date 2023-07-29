class User {
  String name;
  String age;
  String address;
  int? id;

  User({
    required this.name,
    required this.age,
    required this.address,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"] as String,
        age: json["age"] as String,
        address: json["address"] as String,
        id: json["id"] as int,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "age": age,
        "address": address,
        "id": id,
      };

  void updateFromJson(Map<String, dynamic> json) {
    if (json.containsKey('name')) {
      name = json['name'] as String;
    }
    if (json.containsKey('age')) {
      age = json['age'] as String;
    }
    if (json.containsKey('address')) {
      address = json['address'] as String;
    }
  }
}
