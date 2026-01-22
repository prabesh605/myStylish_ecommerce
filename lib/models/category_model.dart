class CategoryModel {
  final String? id;
  final String name;
  final String image;
  final String? code;
  CategoryModel({this.id, this.code, required this.name, required this.image});
  factory CategoryModel.fromJson(Map<String, dynamic> json, String id) {
    return CategoryModel(
      id: id,
      name: json['name'],
      image: json['image'],
      code: json['code'],
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image': image,
    'code': code,
  };
}
