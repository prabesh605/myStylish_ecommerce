import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stylish_ecommerce/models/cart_model.dart';
import 'package:stylish_ecommerce/models/category_model.dart';
import 'package:stylish_ecommerce/models/order_model.dart';
import 'package:stylish_ecommerce/models/product_model.dart';
import 'package:stylish_ecommerce/models/user_model.dart';

class FirebaseService {
  final CollectionReference categoryCollection = FirebaseFirestore.instance
      .collection('categories');
  final CollectionReference productCollection = FirebaseFirestore.instance
      .collection('products');
  final CollectionReference cartCollection = FirebaseFirestore.instance
      .collection('carts');
  final CollectionReference orderCollection = FirebaseFirestore.instance
      .collection('orders');
  final CollectionReference userCollection = FirebaseFirestore.instance
      .collection("users");

  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> addCategory(CategoryModel category) async {
    try {
      await categoryCollection.add(category.toJson());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<CategoryModel>> getAllCategories() async {
    final response = await categoryCollection.get();
    return response.docs
        .map(
          (e) => CategoryModel.fromJson(e.data() as Map<String, dynamic>, e.id),
        )
        .toList();
  }

  Future<void> updateCategory(CategoryModel category) async {
    try {
      await categoryCollection.doc(category.id).update(category.toJson());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> addProduct(ProductModel product) async {
    try {
      await productCollection.add(product.toJson());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<ProductModel>> getAllProduct() async {
    final response = await productCollection.get();
    return response.docs
        .map(
          (e) => ProductModel.fromJson(e.data() as Map<String, dynamic>, e.id),
        )
        .toList();
  }

  Future<void> updateProduct(ProductModel product) async {
    try {
      await productCollection.doc(product.id).update(product.toJson());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //for cart
  Future<void> addCart(CartModel cart) async {
    try {
      await cartCollection.add(cart.toJson());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<CartModel>> getAllCart() async {
    final response = await cartCollection.get();
    return response.docs
        .map((e) => CartModel.fromJson(e.data() as Map<String, dynamic>, e.id))
        .toList();
  }

  Future<void> updateCart(CartModel cart) async {
    try {
      await productCollection.doc(cart.id).update(cart.toJson());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> addOrder(OrderModel order) async {
    try {
      await orderCollection.add(order.toJson());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<OrderModel>> getAllOrder() async {
    try {
      final response = await orderCollection.get();
      return response.docs
          .map(
            (e) => OrderModel.fromJson(e.data() as Map<String, dynamic>, e.id),
          )
          .toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<User?> createUserWithEmailPassword(UserModel user) async {
    try {
      final response = await auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      User? userData = response.user;
      return userData;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  Future<User?> loginUserWithEmailPassword(UserModel user) async {
    try {
      final response = await auth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      User? userData = response.user;
      return userData;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> addUser(UserModel userDetail) async {
    try {
      final User? user = auth.currentUser;
      await userCollection.doc(user?.uid).set(userDetail.toJson());
      // await userCollection.add();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ProductModel> getUserDetail() async {
    final User? user = auth.currentUser;
    final response = await userCollection.doc(user?.uid).get();

    return ProductModel.fromJson(
      response.data() as Map<String, dynamic>,
      response.id,
    );
  }

  Future<void> updateUser(UserModel user) async {
    try {
      await userCollection.doc(user.id).update(user.toJson());
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
