class WishlistModel {
  final String? id;
  final String imageUrl;
  final String name;
  final String description;
  final String categoryId;
  final String categoryName;
  final double price;
  final double initialPrice;
  final double rating;

  WishlistModel({
    this.id,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.categoryName,
    required this.price,
    required this.initialPrice,
    required this.rating,
  });
  factory WishlistModel.fromJson(Map<String, dynamic> json, String id) {
    return WishlistModel(
      id: id,
      imageUrl: json['imageUrl'],
      name: json['name'],
      description: json['description'],
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      price: json['price'],
      initialPrice: json['initialPrice'],
      rating: json['rating'],
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'imageUrl': imageUrl,
    'name': name,
    'description': description,
    'categoryId': categoryId,
    'categoryName': categoryName,
    'price': price,
    'initialPrice': initialPrice,
    'rating': rating,
  };
}
