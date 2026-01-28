class CartModel {
  final String? id;
  final String name;
  final String productDetail;
  final double price;
  final int itemCount;
  final double rating;
  final String categoryId;
  final String categoryName;
  final String imageUrl;

  CartModel({
    this.id,
    required this.name,
    required this.productDetail,
    required this.price,
    required this.itemCount,
    required this.rating,
    required this.categoryId,
    required this.categoryName,
    required this.imageUrl,
  });
  factory CartModel.fromJson(Map<String, dynamic> json, String id) {
    return CartModel(
      id: id,
      name: json['name'],
      productDetail: json['productDetail'],
      price: json['price'],
      itemCount: json['itemCount'],
      rating: json['rating'],
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      imageUrl: json['imageUrl'],
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'productDetail': productDetail,
    'price': price,
    'itemCount': itemCount,
    'rating': rating,
    'categoryId': categoryId,
    'categoryName': categoryName,
    'imageUrl': imageUrl,
  };
}
