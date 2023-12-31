class ClothingCategory {
  int? id;
  bool? active;
  String? arabicName;
  String? englishName;

  ClothingCategory({this.id, this.active, this.arabicName, this.englishName});

  ClothingCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    active = json['active'];
    arabicName = json['arabicName'];
    englishName = json['englishName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['active'] = this.active;
    data['arabicName'] = this.arabicName;
    data['englishName'] = this.englishName;
    return data;
  }
}
