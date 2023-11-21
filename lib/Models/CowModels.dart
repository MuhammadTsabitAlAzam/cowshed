import 'dart:io';

class CowModel {
  String idSapi;
  double suhu;
  File kaki;
  File mulut;
  double lat;
  double lng;

  CowModel({
    required this.idSapi,
    required this.suhu,
    required this.kaki,
    required this.mulut,
    required this.lat,
    required this.lng,
  });

  factory CowModel.fromJson(Map<String, dynamic> json) {
    return CowModel(
      idSapi: json['id_sapi'],
      suhu: double.parse(json['suhu']),
      kaki: File(json['kaki']),
      mulut: File(json['mulut']),
      lat: double.parse(json['lat']),
      lng: double.parse(json['lng']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_sapi': idSapi,
      'suhu': suhu.toString(),
      'kaki': kaki.path,
      'mulut': mulut.path,
    };
  }
}

class CowData {
  String id;
  String idSapi;
  String status;

  CowData({
    required this.id,
    required this.idSapi,
    required this.status,
  });

  factory CowData.fromJson(Map<String, dynamic> json) {
    return CowData(
      id: json['id'],
      idSapi: json['id_sapi'],
      status: json['status'].toString()
    );
  }
}

class CowDataResponse {
  final List<CowData> data;
  final MetaData meta;

  CowDataResponse(this.data, this.meta);
}

class MetaData {
  final int totalItems;
  final int totalPages;
  final int currentPage;

  MetaData(this.totalItems, this.totalPages, this.currentPage);

  factory MetaData.fromJson(Map<String, dynamic> json) {
    return MetaData(
      json['totalItems'] as int,
      json['totalPages'] as int,
      json['currentPage'] as int,
    );
  }
}

class CowApiResponse {
  final String id;
  final String idSapi;
  final String status_suhu;
  final String mulut;
  final String kaki;
  final String status;
  final double suhu;

  CowApiResponse({
    required this.id,
    required this.idSapi,
    required this.status_suhu,
    required this.mulut,
    required this.kaki,
    required this.status,
    required this.suhu,
  });

  factory CowApiResponse.fromJson(Map<String, dynamic> json) {
    return CowApiResponse(
      id: json['id'],
      idSapi: json['id_sapi'],
      status_suhu: json['status_suhu'],
      mulut: json['mulut'],
      kaki: json['kaki'],
      status: json['status'],
      suhu: double.parse(json['suhu']),
    );
  }
}

class CowDetails {
  final String id;
  final String idSapi;
  final String status;
  final String status_suhu;
  final String kaki;
  final String mulut;
  final num suhu;
  final String kakiImg;
  final String mulutImg;
  final DateTime createdAt;
  final Puskeswan puskeswan;
  final Owner owner;

  CowDetails({
    required this.id,
    required this.idSapi,
    required this.status,
    required this.status_suhu,
    required this.kaki,
    required this.mulut,
    required this.suhu,
    required this.kakiImg,
    required this.mulutImg,
    required this.createdAt,
    required this.puskeswan,
    required this.owner,
  });

  factory CowDetails.fromJson(Map<String, dynamic> json) {
    return CowDetails(
      id: json['id'],
      idSapi: json['id_sapi'],
      status: json['status'],
      status_suhu: json['status_suhu'],
      kaki: json['kaki'],
      mulut: json['mulut'],
      suhu: json['suhu'],
      kakiImg: json['kakiImg'],
      mulutImg: json['mulutImg'],
      createdAt: DateTime.parse(json['createdAt']),
      puskeswan: Puskeswan.fromJson(json['puskeswan']),
      owner: Owner.fromJson(json['owner']),
    );
  }
}

class Puskeswan {
  final String id;
  final String name;
  final String noTelp;
  final String address;

  Puskeswan({
    required this.id,
    required this.name,
    required this.noTelp,
    required this.address,
  });

  factory Puskeswan.fromJson(Map<String, dynamic> json) {
    return Puskeswan(
      id: json['id'],
      name: json['name'],
      noTelp: json['no_telp'],
      address: json['address'],
    );
  }
}

class Owner {
  final String id;
  final String address;
  final String noTelp;
  final double? lat;
  final double? lng;

  Owner({
    required this.id,
    required this.address,
    required this.noTelp,
    required this.lat,
    required this.lng,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json['id'],
      address: json['address'],
      noTelp: json['no_telp'],
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}

