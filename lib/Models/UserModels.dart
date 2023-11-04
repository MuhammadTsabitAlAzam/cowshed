import 'dart:io';

class LoginRequest {
  String? username;
  String? password;

  LoginRequest({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password,
    };
  }
}

class User {
  String? id;
  String? username;
  String? password;
  String? name;
  String? address;
  String? no_telp;
  String? role;
  String? profileImg;
  double? lat;
  double? lng;


  User({
    this.id,
    this.username,
    this.password,
    this.name,
    this.address,
    this.no_telp,
    this.role,
    this.profileImg,
    this.lat,
    this.lng,
  });

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      id: map["id"],
      username: map["username"],
      password: map["password"],
      name: map["name"],
      address: map["address"],
      no_telp: map["no_telp"],
      role: map["role"],
      profileImg: map["profileImg"],
      lat: map["lat"],
      lng: map["lng"],
    );
  }

  Map<String, dynamic> RegtoJson() {
    return {
      "username": username,
      "password": password,
      "name": name,
      "address": address,
      "no_telp": no_telp,
      "role" : role,
      "lat" : lat,
      "lng" : lng
    };
  }

  @override
  String toString() {
    return 'User{id: $id, username: $username, password: $password, name : $name, address: $address, no_telp: $no_telp}';
  }
}

class UserUpdate {
  String? id;
  String? username;
  String? password;
  String? name;
  String? address;
  String? no_telp;
  String? role;
  File? profile;
  String? lat;
  String? lng;

  UserUpdate({
    this.id,
    this.username,
    this.password,
    this.name,
    this.address,
    this.no_telp,
    this.role,
    this.profile,
    this.lat,
    this.lng,
  });

  Map<String, dynamic> UpdatetoJson() {
    return {
      "username": username,
      "password": password,
      "name": name,
      "address": address,
      "no_telp": no_telp,
      "profile": profile,
      "lat": lat,
      "lng": lng,
    };
  }
}