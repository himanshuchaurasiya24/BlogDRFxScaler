class RegistrationModel {
  String? username;
  String? password;
  String? firstName;
  String? lastName;

  RegistrationModel(
      {this.username, this.password, this.firstName, this.lastName});

  RegistrationModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    return data;
  }
}
