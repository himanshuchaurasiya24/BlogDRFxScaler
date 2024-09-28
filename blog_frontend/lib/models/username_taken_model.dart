class UsernameTakenModel {
  String? message;
  Data? data;

  UsernameTakenModel({this.message, this.data});

  UsernameTakenModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<String>? nonFieldErrors;

  Data({this.nonFieldErrors});

  Data.fromJson(Map<String, dynamic> json) {
    nonFieldErrors = json['non_field_errors'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['non_field_errors'] = nonFieldErrors;
    return data;
  }
}
