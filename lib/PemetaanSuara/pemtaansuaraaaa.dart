String? token = "";

Map<String, dynamic> loginData = {
  "token": "",
  "userID": 1,
  "nama": "",
  "role": "",
};
List<LoginModel> login = [];

class LoginModel {
  int? id;
  String? role;
  LoginModel({this.id, this.role});
}
