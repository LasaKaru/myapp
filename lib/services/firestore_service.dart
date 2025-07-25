import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get a stream of products for real-time updates
  Stream<List<Product>> getProductsStream(String query) {
    Query productsQuery = _db.collection('products');
    
    // NOTE: Firestore's basic text search is limited. For more advanced
    // search, you'd typically use a third-party service like Algolia.
    // This is a simple "starts with" search.
    if (query.isNotEmpty) {
        productsQuery = productsQuery.where('productName', isGreaterThanOrEqualTo: query)
                                     .where('productName', isLessThanOrEqualTo: query + '\uf8ff');
    }

    return productsQuery.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Product.fromFirestore(doc))
        .toList());
  }

  // Add a new product
  Future<void> addProduct(Product product) {
    return _db.collection('products').add(product.toMap());
  }

  // Update an existing product
  Future<void> updateProduct(Product product) {
    return _db.collection('products').doc(product.id).update(product.toMap());
  }
}