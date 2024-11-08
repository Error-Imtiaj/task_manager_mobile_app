
class TaskStstusCountModel {
  String? id;
  int? sum;

  TaskStstusCountModel({this.id, this.sum});

  TaskStstusCountModel.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["sum"] is int) {
      sum = json["sum"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["sum"] = sum;
    return _data;
  }
}