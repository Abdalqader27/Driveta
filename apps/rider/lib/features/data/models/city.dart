class CitiesList {
  int? id;
  String? name;
  bool? isSelected;

  CitiesList({this.id, this.name});

  CitiesList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
