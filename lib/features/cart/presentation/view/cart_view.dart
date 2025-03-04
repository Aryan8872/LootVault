// features/cart/presentation/screens/cart_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loot_vault/app/di/di.dart';
import 'package:loot_vault/features/cart/presentation/view/checkout_confirmation_view.dart';
import 'package:loot_vault/features/cart/presentation/view_model/cart_bloc.dart';
import 'package:loot_vault/features/cart/presentation/view_model/cart_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Implement clear cart functionality
            },
          ),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.cartItems == null || state.cartItems!.isEmpty) {
            return const Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.cartItems!.length,
                  itemBuilder: (context, index) {
                    final item = state.cartItems![index];
                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            'http://192.168.1.64:3000/public/uploads/${item.productImage}',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          item.productName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Text(
                          '\$${item.productPrice} x ${item.quantity}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            // Implement remove from cart functionality
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                            value: getIt<CartBloc>(),
                            child: CheckoutConfirmationView(
                              cartItems: state.cartItems!,
                            ),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Checkout',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
