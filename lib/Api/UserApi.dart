import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import '../Models/UserModels.dart';
import 'package:http_parser/http_parser.dart';

class ApiServiceUser {
  final String baseUrl = "http://62.72.56.98:4000";
  final http.Client client = http.Client();
  final storage = FlutterSecureStorage();

  Future<User> getUser(int id) async {
    try {
      final response = await client.get(Uri.parse("$baseUrl/user/$id"));
      if (response.statusCode == 200) {
        final userJson = json.decode(response.body);
        return User.fromJson(userJson);
      } else {
        throw Exception("Failed to fetch data from API");
      }
    } catch (e) {
      throw Exception("Failed to connect to API: $e");
    }
  }

  Future<http.Response> registerUser(User userData) async {
    try {
      final response = await client.post(
        Uri.parse("$baseUrl/auth/register"),
        headers: {
          "content-type": "application/json",
        },
        body: jsonEncode(userData.RegtoJson()),
      );
      return response;
    } catch (e) {
      throw Exception("Failed to register user: $e");
    }
  }

  Future<http.Response> loginUser(LoginRequest loginData) async {
    try {
      final response = await client.post(
        Uri.parse("$baseUrl/auth/login"),
        headers: {
          "content-type": "application/json",
        },
        body: jsonEncode(loginData.toJson()),
      );
      return response;
    } catch (e) {
      throw Exception("Failed to login: $e");
    }
  }

  Future<bool> checkPermission() async {
    final accessToken = await getAccessToken();
    if (accessToken == null) {
      throw Exception("Access token not found");
    }

    final response = await client.get(
      Uri.parse("$baseUrl/auth"),
      headers: {
        "Authorization": "Bearer $accessToken",
      },
    );

    if (response.statusCode == 200) {
        return true;
    } else if (response.statusCode == 401) {
      return false;
    } else {
    throw Exception("Failed to check permission");
    }
  }

  Future<User> getUserDetailsWithAccessToken() async {
    final accessToken = await getAccessToken();
    if (accessToken == null) {
      throw Exception("Access token not found");
    }

    try {
      final response = await client.get(
        Uri.parse("$baseUrl/users/profile"),
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        final userJson = json.decode(response.body);
        return User.fromJson(userJson);
      } else {
        throw Exception("Failed to fetch user details from API");
      }
    } catch (e) {
      throw Exception("Failed to connect to API: $e");
    }
  }

  Future<http.Response> updateUserProfile(UserUpdate userUpdate, String token) async {
    try {
      var request = http.MultipartRequest('PATCH', Uri.parse("$baseUrl/users/profile"));
      request.headers['Authorization'] = "Bearer $token";

      final profile = userUpdate.profile;
      if (profile != null) {
        var _profile = await http.MultipartFile.fromPath(
          'profile',
          profile.path,
          contentType: MediaType('image', 'jpeg'),
        );
        request.files.add(_profile);
      }

      request.fields['username'] = userUpdate.username.toString();
      request.fields['name'] = userUpdate.name.toString();
      request.fields['address'] = userUpdate.address.toString();
      request.fields['no_telp'] = userUpdate.no_telp.toString();
      if (userUpdate.password != null && userUpdate.password!.isNotEmpty) {
        request.fields['password'] = userUpdate.password.toString();
      }
      if (userUpdate.lat != null && userUpdate.lat!.isNotEmpty) {
        request.fields['lat'] = userUpdate.lat.toString();
      }
      if (userUpdate.lng != null && userUpdate.lng!.isNotEmpty) {
        request.fields['lng'] = userUpdate.lng.toString();
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      return response;

    } catch (e) {
      throw Exception("Failed to update user profile: $e");
    }
  }




  Future<void> saveUserData(String name, String accessToken, String role) async {
    await storage.write(key: 'access_token', value: accessToken);
    await storage.write(key: 'name', value: name);
    await storage.write(key: 'role', value: role);
  }

  Future<String?> getAccessToken() async {
    return await storage.read(key: 'access_token');
  }

  Future<String?> getUserName() async {
    return await storage.read(key: 'name');
  }

  Future<String?> getRole() async {
    return await storage.read(key: 'role');
  }

  Future<void> deleteAccessToken() async {
    return await storage.delete(key: 'access_token');
  }

  Future<void> deleteUserName() async {
    return await storage.delete(key: 'name');
  }

  Future<void> deleteRole() async {
    return await storage.delete(key: 'role');
  }

}


