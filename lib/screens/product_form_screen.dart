import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/firestore_service.dart';

class ProductFormScreen extends StatefulWidget {
  final Product? product; // Null if creating a new product

  const ProductFormScreen({super.key, this.product});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firestoreService = FirestoreService();
  late TextEditingController _codeController;
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController(text: widget.product?.productCode ?? '');
    _nameController = TextEditingController(text: widget.product?.productName ?? '');
    _priceController = TextEditingController(text: widget.product?.price.toString() ?? '');
  }

  void _saveProduct() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);

      final productToSave = Product(
        id: widget.product?.id, // Keep the id for updates
        productCode: _codeController.text,
        productName: _nameController.text,
        price: double.tryParse(_priceController.text) ?? 0.0,
      );

      try {
        if (widget.product == null) {
          await _firestoreService.addProduct(productToSave);
        } else {
          await _firestoreService.updateProduct(productToSave);
        }
        
        if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Product saved successfully!')),
            );
            Navigator.of(context).pop();
        }
      } catch (e) {
         if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to save product: $e')),
            );
         }
      } finally {
        if (mounted) {
            setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product == null ? 'New Product' : 'Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _codeController,
                decoration: const InputDecoration(labelText: 'Product Code'),
                validator: (value) => (value?.isEmpty ?? true) ? 'This field is required' : null,
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
                validator: (value) => (value?.isEmpty ?? true) ? 'This field is required' : null,
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'This field is required';
                  if (double.tryParse(value!) == null) return 'Price must be a valid number';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _saveProduct,
                      child: const Text('Save'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}