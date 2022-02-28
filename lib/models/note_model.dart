class User {
  String? id;
  String? email;
  String? password;

  User({this.id, this.email, this.password});

  User.from({this.email, this.password});

  User.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        email = json['email'],
        password = json['password'];

  Map<dynamic, dynamic> toJson() => {
    'id': id,
    'email': email,
    'password': password,
  };
}



class Note {
  late int id;
  late DateTime createTime;
  DateTime? editTime;
  late String title;
  late String content;

  Note({
    required this.id,
    required this.createTime,
    this.editTime,
    required this.title,
    required this.content,
  });

  Note.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createTime = DateTime.parse(json['createTime']);
    title = json['title'];
    content = json['content'];
    editTime = json['editTime'] != "null" &&json['editTime'] != null  ? DateTime.parse(json['editTime']) : null;
  }

  Map<String, dynamic> toJson() => {
    'id' : id,
    'createTime' : createTime.toString(),
    'editTime' : editTime.toString(),
    'title' : title,
    'content' : content,
  };
}