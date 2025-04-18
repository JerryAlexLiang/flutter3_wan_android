/// 创建日期: 2025/04/18 14:28
/// 作者: Jerry
/// 描述: 项目分类一级liebiao
class TreeModel {
  String? author;
  int? courseId;
  String? cover;
  String? desc;
  int? id; // 该id在获取该分类下项目时需要用到
  String? lisense;
  String? lisenseLink;
  String? name; // 该分类名称
  int? order;
  int? parentChapterId;
  int? type;
  bool? userControlSetTop;
  int? visible;

  TreeModel(
      {this.author,
      this.courseId,
      this.cover,
      this.desc,
      this.id,
      this.lisense,
      this.lisenseLink,
      this.name,
      this.order,
      this.parentChapterId,
      this.type,
      this.userControlSetTop,
      this.visible});

  TreeModel.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    courseId = json['courseId'];
    cover = json['cover'];
    desc = json['desc'];
    id = json['id'];
    lisense = json['lisense'];
    lisenseLink = json['lisenseLink'];
    name = json['name'];
    order = json['order'];
    parentChapterId = json['parentChapterId'];
    type = json['type'];
    userControlSetTop = json['userControlSetTop'];
    visible = json['visible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['author'] = author;
    data['courseId'] = courseId;
    data['cover'] = cover;
    data['desc'] = desc;
    data['id'] = id;
    data['lisense'] = lisense;
    data['lisenseLink'] = lisenseLink;
    data['name'] = name;
    data['order'] = order;
    data['parentChapterId'] = parentChapterId;
    data['type'] = type;
    data['userControlSetTop'] = userControlSetTop;
    data['visible'] = visible;
    return data;
  }
}
