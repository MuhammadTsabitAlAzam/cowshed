import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../Models/CowModels.dart';

class ApiServiceCow {
  final String baseUrl = "http://62.72.56.98:4000";
  final http.Client client = http.Client();
  final storage = FlutterSecureStorage();

  Future<String?> getAccessToken() async {
    return await storage.read(key: 'access_token');
  }

  Future<http.Response> uploadCowData(CowModel cowData) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/cows'),
      );

      String? accessToken = await getAccessToken();

      if (accessToken != null) {
        request.headers['Authorization'] = 'Bearer $accessToken';
      }

      request.fields['id_sapi'] = cowData.idSapi;
      request.fields['suhu'] = cowData.suhu.toString();
      request.fields['lat'] = cowData.lat.toString();
      request.fields['lng'] = cowData.lng.toString();

      var _kaki = await http.MultipartFile.fromPath(
        'kaki',
        cowData.kaki.path,
        contentType: MediaType('image', 'jpeg'),
      );
      request.files.add(_kaki);

      var _mulut = await http.MultipartFile.fromPath(
        'mulut',
        cowData.mulut.path,
        contentType: MediaType('image', 'jpeg'),
      );
      request.files.add(_mulut);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response;
    } catch (e) {
      throw Exception("Failed to upload cow data: $e");
    }
  }


  Future<CowDataResponse> getCowData({String? idSapi, String? status ,int? pageNumber, int? pageSize}) async {
    try {
      String? accessToken = await getAccessToken();

      if (accessToken == null) {
        throw Exception("Access token is not available.");
      }

      final Map<String, String> queryParameters = {};
      if (idSapi != null) {
        queryParameters['search[id_sapi]'] = idSapi;
      }
      if (status != null) {
        queryParameters['search[status]'] = status;
      }
      if (pageNumber != null) {
        queryParameters['page[number]'] = pageNumber.toString();
      }
      if (pageSize != null) {
        queryParameters['page[size]'] = pageSize.toString();
      }

      final Uri uri = Uri.parse('$baseUrl/cows').replace(queryParameters: queryParameters);

      var response = await client.get(
        uri,
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<CowData> cowDataList = (responseData['data'] as List)
            .map((item) => CowData.fromJson(item))
            .toList();
        final MetaData metaData = MetaData.fromJson(responseData['meta']);
        return CowDataResponse(cowDataList, metaData);
      } else {
        throw Exception('Failed to fetch cow data');
      }
    } catch (e) {
      throw Exception("Failed to fetch cow data: $e");
    }
  }

  Future<http.Response> deleteCowData(String id) async {
    try {
      String? accessToken = await getAccessToken();

      if (accessToken == null) {
        throw Exception("Access token is not available.");
      }

      final Uri uri = Uri.parse('$baseUrl/cows/$id');

      var response = await client.delete(
        uri,
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      return response;
    } catch (e) {
      throw Exception("Failed to delete cow data: $e");
    }
  }

  Future<CowDetails> getCowDetails(String cowId) async {
    try {
      String? accessToken = await getAccessToken();

      if (accessToken == null) {
        throw Exception("Access token is not available.");
      }

      final response = await http.get(
        Uri.parse('$baseUrl/cows/$cowId'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return CowDetails.fromJson(jsonBody);
      } else {
        throw Exception('Gagal mengambil data sapi');
      }
    } catch (e) {
      throw Exception("Failed to get cow details: $e");
    }
  }
}

