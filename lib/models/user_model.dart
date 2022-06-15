class UserModel
{
  final int userId;
  final String userEmail;
  final String access_token;

  UserModel({required this.userId, required this.userEmail, required this.access_token});

  static UserModel fromJson(json)
  {
    return UserModel(userId: json['userId'], userEmail: json['userEmail'], access_token: json['access_token']);
  }

  static Map<String, dynamic> toJson(UserModel user) {
    Map<String, dynamic> jsonMap = {
      "userId": user.userId,
      "userEmail": user.userEmail,
      "access_token": user.access_token,
    };

    return jsonMap;
  }
}