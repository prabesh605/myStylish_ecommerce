import 'package:stylish_ecommerce/models/wishlist_model.dart';

abstract class WishlistEvent {}

class AddToWishList extends WishlistEvent {
  final WishlistModel wishlist;
  AddToWishList(this.wishlist);
}

class GetWishList extends WishlistEvent {}

class DeleteWishlist extends WishlistEvent {
  final WishlistModel wishlist;
  DeleteWishlist(this.wishlist);
}
