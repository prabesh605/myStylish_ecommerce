import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_ecommerce/bloc/wishlist/wishlist_event.dart';
import 'package:stylish_ecommerce/bloc/wishlist/wishlist_state.dart';
import 'package:stylish_ecommerce/service/firebase_service.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  FirebaseService service;
  WishlistBloc(this.service) : super(WishlistInitial()) {
    on<AddToWishList>((event, emit) async {
      emit(WishlistLoading());
      await service.addWishList(event.wishlist);
      final wishlistData = await service.getMyWishtlist();
      emit(WishlistLoaded(wishlistData));
    });
    on<GetWishList>((event, emit) async {
      emit(WishlistLoading());
      final wishlistData = await service.getMyWishtlist();
      emit(WishlistLoaded(wishlistData));
    });
    on<DeleteWishlist>((event, emit) async {
      emit(WishlistLoading());
      await service.removeWishlist(event.wishlist);
      final wishlistData = await service.getMyWishtlist();
      emit(WishlistLoaded(wishlistData));
    });
  }
}
