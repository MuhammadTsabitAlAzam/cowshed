class DaftarUser {
  String id;
  String username;
  String name;
  String role;

  DaftarUser({
    required this.id,
    required this.username,
    required this.name,
    required this.role,
  });

  factory DaftarUser.fromJson(Map<String, dynamic> json) {
    return DaftarUser(
        id: json['id'],
        username: json['username'],
        name: json['name'].toString(),
        role: json['role'].toString()
    );
  }
}

class DaftarUserResponse {
  final List<DaftarUser> data;
  final MetaData meta;

  DaftarUserResponse(this.data, this.meta);
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