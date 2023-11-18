class BaseResponse {
  final dynamic data;
  final bool status;

  BaseResponse({required this.data, required this.status});

  Map<String, dynamic> toMap() {
    return {
      'data': data,
      'status': status,
    };
  }

  factory BaseResponse.fromMap(Map<String, dynamic> map) {
    return BaseResponse(
      data: map['message'],
      status: map['status'] == "success",
    );
  }
}
