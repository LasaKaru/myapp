import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product {
  // Firestore document IDs are strings and are separate from the data
  final String? id; 
  final String productCode;
  final String productName;
  final double price;

  Product({
    this.id,
    required this.productCode,
    required this.productName,
    required this.price,
  });

  // A factory to create a Product from a Firestore document
  factory Product.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      productCode: data['productCode'] ?? '',
      productName: data['productName'] ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
    );
  }

  // A method to convert a Product instance to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'productCode': productCode,
      'productName': productName,
      'price': price,
    };
  }
}

