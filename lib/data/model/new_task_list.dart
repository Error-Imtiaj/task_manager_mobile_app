
class NewTaskList {
  String? id;
  String? title;
  String? description;
  String? status;
  String? email;
  String? createdDate;

  NewTaskList({this.id, this.title, this.description, this.status, this.email, this.createdDate});

  NewTaskList.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["title"] is String) {
      title = json["title"];
    }
    if(json["description"] is String) {
      description = json["description"];
    }
    if(json["status"] is String) {
      status = json["status"];
    }
    if(json["email"] is String) {
      email = json["email"];
    }
    if(json["createdDate"] is String) {
      createdDate = json["createdDate"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["title"] = title;
    _data["description"] = description;
    _data["status"] = status;
    _data["email"] = email;
    _data["createdDate"] = createdDate;
    return _data;
  }
}