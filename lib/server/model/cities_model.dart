class Cities {
  Cities({
    required this.id,
    required this.nameEn,
    required this.nameAr,
  });
  late final int id;
  late final String nameEn;
  late final String nameAr;

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name_en'] = nameEn;
    data['name_ar'] = nameAr;
    return data;
  }

  String userAsString() {
    return nameAr;
  }
}
