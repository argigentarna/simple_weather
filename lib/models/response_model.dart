class ResponseModel {
  int? rc;
  dynamic data;
  dynamic message;

  ResponseModel({
    this.rc,
    this.data,
    this.message,
  });

  ResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    rc = json['rc'].toInt();
    data = json['data'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rc'] = this.rc;
    data['data'] = this.data;
    data['message'] = this.message;
    return data;
  }
}
