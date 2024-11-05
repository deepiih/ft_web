class User {
  User({
    this.id,
    this.email,
    this.name,
  });

  User.fromJson(dynamic json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
  }
  num? id;
  String? email;
  String? name;
  User copyWith({
    num? id,
    String? email,
    String? name,
  }) =>
      User(
        id: id ?? this.id,
        email: email ?? this.email,
        name: name ?? this.name,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['name'] = name;
    return map;
  }
}
