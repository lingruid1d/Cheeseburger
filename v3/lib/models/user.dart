/// 用户实体类
class User {
  late String? username;
  late int? id;

  User({
    this.username,
    this.id,
  });

  static User fromMap(Map<String, dynamic> map) {
    User user = User();
    user.username = map['username'];
    user.id = map['id'];

    return user;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'username': username,
      'id': id,
    };
    return map;
  }
}
