import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loot_vault/app/di/di.dart';
import 'package:loot_vault/features/games/presentation/view/add_product.dart';
import 'package:loot_vault/features/games/presentation/view_model/game_bloc.dart';
import 'package:loot_vault/features/seller/presentation/view/bottom_view/seller_dashboard_view.dart';
import 'package:loot_vault/features/seller/presentation/view_model/seller_state.dart';
import 'package:loot_vault/features/skins/presentation/view/add_product.dart';
import 'package:loot_vault/features/skins/presentation/view_model/skin_bloc.dart';

class SellerCubit extends Cubit<SellerState> {
  SellerCubit()
      : super(
          SellerState(
            selectedIndex: 0,
            views: [
              const SellerDashboardView(),
              BlocProvider.value(
                value: getIt<GameBloc>(),
                child: const AddGameScreen(),
              ),
              BlocProvider.value(
                value: getIt<SkinBloc>(),
                child: const AddSkinScreen(),
              ),
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
