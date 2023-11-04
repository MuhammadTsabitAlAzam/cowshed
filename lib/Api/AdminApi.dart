import 'dart:convert';
import 'package:cowshed/Models/AdminModels.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ApiServiceAdmin{
  final String baseUrl = "http://62.72.56.98:4000";
  final http.Client client = http.Client();
  final storage = FlutterSecureStorage();

  Future<String?> getAccessToken() async {
    return await storage.read(key: 'access_token');
  }

  Future<DaftarUserResponse> getUsersData({String? name, String? role ,int? pageNumber, int? pageSize}) async {
    try {
      String? accessToken = await getAccessToken();

      if (accessToken == null) {
        throw Exception("Access token is not available.");
      }

      final Map<String, String> queryParameters = {};
      if (name != null) {
        queryParameters['search[name]'] = name;
      }
      if (role != null) {
        queryParameters['search[role]'] = role;
      }
      if (pageNumber != null) {
        queryParameters['page[number]'] = pageNumber.toString();
      }
      if (pageSize != null) {
        queryParameters['page[size]'] = pageSize.toString();
      }

      final Uri uri = Uri.parse('$baseUrl/users').replace(queryParameters: queryParameters);

      var response = await client.get(
        uri,
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<DaftarUser> cowDataList = (responseData['data'] as List)
            .map((item) => DaftarUser.fromJson(item))
            .toList();
        final MetaData metaData = MetaData.fromJson(responseData['meta']);
        return DaftarUserResponse(cowDataList, metaData);
      } else {
        throw Exception('Failed to fetch users data');
      }
    } catch (e) {
      throw Exception("Failed to fetch users data: $e");
    }
  }

  Future<http.Response> deleteUsersData(String id) async {
    try {
      String? accessToken = await getAccessToken();

      if (accessToken == null) {
        throw Exception("Access token is not available.");
      }

      final Uri uri = Uri.parse('$baseUrl/users/$id');

      var response = await client.delete(
        uri,
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      return response;
    } catch (e) {
      throw Exception("Failed to delete users data: $e");
    }
  }
}