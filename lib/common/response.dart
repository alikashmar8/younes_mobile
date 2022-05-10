// ignore_for_file: prefer_null_aware_operators

class Response<T> {
  bool status = false;
  String message = '';
  late T data;
  Response({required this.status, required this.message, required this.data});

  factory Response.fromJson(
      Map<String, dynamic> json, Function(Map<String, dynamic>) create) {
    return Response<T>(
      status: json["status"],
      message: json["message"],
      data: create(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data != null ? data.toString() : null,
      };
}

// ignore: constant_identifier_names
enum Status { LOADING, COMPLETED, ERROR }
