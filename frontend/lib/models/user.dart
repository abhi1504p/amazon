import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String address;
  final String type;
  final String token;

  //<editor-fold desc="Data Methods">
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.type,
    required this.token,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email &&
          password == other.password &&
          address == other.address &&
          type == other.type &&
          token == other.token);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      password.hashCode ^
      address.hashCode ^
      type.hashCode ^
      token.hashCode;

  @override
  String toString() {
    return 'User{' +
        ' id: $id,' +
        ' name: $name,' +
        ' email: $email,' +
        ' password: $password,' +
        ' address: $address,' +
        ' type: $type,' +
        ' token: $token,' +
        '}';
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? address,
    String? type,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      type: type ?? this.type,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'type': type,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      address: map['address'] as String,
      type: map['type'] as String,
      token: map['token'] as String,
    );
  }
  String toJson() => json.encode(toMap());
  factory User.fromJson(String source) => User.fromMap(json.decode(source));
  //</editor-fold>
}
