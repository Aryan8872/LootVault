import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loot_vault/features/seller/presentation/view_model/seller_state.dart';
import 'package:loot_vault/features/seller/presentation/view/bottom_view/seller_dashboard_view.dart';

class SellerCubit extends Cubit<SellerState> {
  SellerCubit()
      : super(
          SellerState(
            selectedIndex: 0,
            views: [
              const SellerDashboardView(),
              const AddProductView(),
              const ManageProductsView(),
            ],
          ),
        );

  void onTabTapped(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  // Add other seller-specific functions
  void refreshProducts() {
    // Logic to refresh product list
    emit(state);
  }

  void deleteProduct(String productId) {
    // Implement delete functionality
    // After deletion:
    refreshProducts();
  }
}